use std::process::Command;
use std::thread;
use std::time::Duration;

use sysinfo::Components;

fn cpu_temp_celsius(components: &Components) -> Option<f32> {
    let mut sum = 0.0_f32;
    let mut count = 0_u32;

    for component in components.iter() {
        let label = component.label();
        let is_cpu_sensor = label.contains("CPU") || label.contains("PMU") || label.contains("SOC");
        if !is_cpu_sensor {
            continue;
        }

        if let Some(temp) = component.temperature() {
            if temp.is_finite() && (0.0..=125.0).contains(&temp) {
                sum += temp;
                count += 1;
            }
        }
    }

    if count > 0 {
        Some(sum / count as f32)
    } else {
        None
    }
}

fn trigger_sketchybar(temp_label: &str) {
    let _ = Command::new("sketchybar")
        .args(["--trigger", "cpu_temp_update", &format!("CPU_TEMP={temp_label}")])
        .status();
}

fn main() {
    let mut components = Components::new_with_refreshed_list();

    loop {
        components.refresh(false);

        let label = match cpu_temp_celsius(&components) {
            Some(temp) => format!("{temp:.1}°C"),
            None => String::from("N/A"),
        };

        trigger_sketchybar(&label);
        thread::sleep(Duration::from_secs(4));
    }
}
