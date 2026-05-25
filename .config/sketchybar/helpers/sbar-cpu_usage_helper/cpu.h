#include <stdio.h>
#include <stdlib.h>
#include <mach/mach.h>
#include <stdbool.h>

#define MAX_TOPPROC_LEN 12

static const char TOPPROC[] = { "/bin/ps -Aceo pid=,pcpu=,comm= -r" };
static const char APPLE_PROCESS_PREFIX[] = { "com.apple." };

static inline const char* cpu_color_for_usage(double total_perc) {
  if (total_perc >= .8) return getenv("HIGH");
  if (total_perc >= .55) return getenv("MEDIUM");
  if (total_perc >= .3) return getenv("LOW");
  return getenv("BASE");
}

static inline void format_top_process_label(char* destination, size_t size, int pid, double top_pcpu, const char* command) {
  const char* command_name = command;
  if (strncmp(command, APPLE_PROCESS_PREFIX, strlen(APPLE_PROCESS_PREFIX)) == 0) {
    command_name += strlen(APPLE_PROCESS_PREFIX);
  }

  char truncated_command[MAX_TOPPROC_LEN + 4] = { 0 };
  uint32_t caret = 0;
  for (int i = 0; command_name[i] != '\0'; i++) {
    if (caret >= MAX_TOPPROC_LEN && caret <= MAX_TOPPROC_LEN + 2) {
      truncated_command[caret++] = '.';
      continue;
    }
    if (caret > MAX_TOPPROC_LEN + 2) break;
    truncated_command[caret++] = command_name[i];
  }

  snprintf(destination, size, "%d %.1f%% %s", pid, top_pcpu, truncated_command);
}

struct cpu {
  host_t host;
  mach_msg_type_number_t count;
  host_cpu_load_info_data_t load;
  host_cpu_load_info_data_t prev_load;
  bool has_prev_load;

  char command[256];
};

static inline void cpu_init(struct cpu* cpu) {
  cpu->host = mach_host_self();
  cpu->count = HOST_CPU_LOAD_INFO_COUNT;
  cpu->has_prev_load = false;
  cpu->command[0] = '\0';
}

static inline void cpu_update(struct cpu* cpu) {
  kern_return_t error = host_statistics(cpu->host,
                                        HOST_CPU_LOAD_INFO,
                                        (host_info_t)&cpu->load,
                                        &cpu->count                );

  if (error != KERN_SUCCESS) {
    printf("Error: Could not read cpu host statistics.\n");
    return;
  }

  if (cpu->has_prev_load) {
    uint32_t delta_user = cpu->load.cpu_ticks[CPU_STATE_USER]
                          - cpu->prev_load.cpu_ticks[CPU_STATE_USER];

    uint32_t delta_system = cpu->load.cpu_ticks[CPU_STATE_SYSTEM]
                            - cpu->prev_load.cpu_ticks[CPU_STATE_SYSTEM];

    uint32_t delta_idle = cpu->load.cpu_ticks[CPU_STATE_IDLE]
                          - cpu->prev_load.cpu_ticks[CPU_STATE_IDLE];

    double user_perc = (double)delta_user / (double)(delta_system
                                                     + delta_user
                                                     + delta_idle);

    double sys_perc = (double)delta_system / (double)(delta_system
                                                      + delta_user
                                                      + delta_idle);

    double total_perc = user_perc + sys_perc;

    FILE* file;
    char line[1024];

    file = popen(TOPPROC, "r");
    if (!file) {
      printf("Error: TOPPROC command errored out...\n" );
      return;
    }

    if (!fgets(line, sizeof(line), file)) {
      pclose(file);
      return;
    }

    int pid = 0;
    double top_pcpu = 0.0;
    char top_command[1024] = { 0 };
    if (sscanf(line, "%d %lf %1023[^\n]", &pid, &top_pcpu, top_command) != 3) {
      pclose(file);
      return;
    }

    char topproc[MAX_TOPPROC_LEN + 24];
    format_top_process_label(topproc, sizeof(topproc), pid, top_pcpu, top_command);

    pclose(file);

    const char* color = cpu_color_for_usage(total_perc);

    snprintf(cpu->command, 256, "--push cpu.sys %.2f "
                                "--push cpu.user %.2f "
                                "--set cpu.top label='%s' "
                                "--set cpu.percent label=%.0f%% label.color=%s ",
                                sys_perc,
                                user_perc,
                                topproc,
                                total_perc*100.,
                                color          );
  }
  else {
    cpu->command[0] = '\0';
  }

  cpu->prev_load = cpu->load;
  cpu->has_prev_load = true;
}
