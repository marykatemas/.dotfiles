use std::process::Command;
use std::thread;
use std::time::Duration;

use sysinfo::Networks;

const NETWORK_UNITS: [&str; 5] = ["B/s", "KB/s", "MB/s", "GB/s", "TB/s"];

fn format_network_rate(bytes_per_second: f64) -> String {
    let mut value = bytes_per_second;
    let mut unit_index = 0_usize;

    while value >= 1024.0 && unit_index < NETWORK_UNITS.len() - 1 {
        value /= 1024.0;
        unit_index += 1;
    }

    if value >= 100.0 {
        format!("{value:.0}{}", NETWORK_UNITS[unit_index])
    } else {
        format!("{value:.1}{}", NETWORK_UNITS[unit_index])
    }
}

fn is_ignored_interface(name: &str) -> bool {
    matches!(name, "lo" | "lo0")
        || name.starts_with("utun")
        || name.starts_with("awdl")
        || name.starts_with("llw")
}

fn current_rates(networks: &Networks, interval_secs: u64) -> Option<(String, String)> {
    let mut best_total = 0_u64;
    let mut best_download = 0_u64;
    let mut best_upload = 0_u64;

    for (name, data) in networks {
        if is_ignored_interface(name.as_str()) {
            continue;
        }

        let download = data.received() / interval_secs;
        let upload = data.transmitted() / interval_secs;
        let total = download.saturating_add(upload);

        if total > best_total {
            best_total = total;
            best_download = download;
            best_upload = upload;
        }
    }

    if best_total == 0 {
        return None;
    }

    Some((
        format_network_rate(best_download as f64),
        format_network_rate(best_upload as f64),
    ))
}

fn trigger_sketchybar(download_label: &str, upload_label: &str) {
    let _ = Command::new("sketchybar")
        .args([
            "--trigger",
            "network_speed_update",
            &format!("NETWORK_DOWNLOAD={download_label}"),
            &format!("NETWORK_UPLOAD={upload_label}"),
        ])
        .status();
}

fn main() {
    let interval_secs = 4_u64;
    let mut networks = Networks::new_with_refreshed_list();

    loop {
        thread::sleep(Duration::from_secs(interval_secs));
        networks.refresh(true);

        let (download_label, upload_label) = current_rates(&networks, interval_secs)
            .unwrap_or_else(|| (String::from("0B/s"), String::from("0B/s")));

        trigger_sketchybar(&download_label, &upload_label);
    }
}
