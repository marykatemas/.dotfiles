#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

db_path="$HOME/Library/Group Containers/group.com.apple.usernoted/db2/db"
cutoff_file="$STATE_DIR/notifications_cutoff"
dialog_lock_dir="$STATE_DIR/notifications_dialog.lock"
dialog_pid_file="$dialog_lock_dir/pid"

mkdir -p "$STATE_DIR"

if [ ! -f "$cutoff_file" ]; then
  python3 -c "import time; print(time.time() - 978307200)" >"$cutoff_file"
fi

acquire_dialog_lock() {
  if mkdir "$dialog_lock_dir" 2>/dev/null; then
    printf '%s\n' "$$" >"$dialog_pid_file"
    trap 'rm -rf "$dialog_lock_dir"' EXIT INT TERM
    return 0
  fi

  if [ -r "$dialog_pid_file" ]; then
    read -r dialog_pid <"$dialog_pid_file"
    if [ -n "$dialog_pid" ] && kill -0 "$dialog_pid" 2>/dev/null; then
      return 1
    fi
  fi

  rm -rf "$dialog_lock_dir"
  if mkdir "$dialog_lock_dir" 2>/dev/null; then
    printf '%s\n' "$$" >"$dialog_pid_file"
    trap 'rm -rf "$dialog_lock_dir"' EXIT INT TERM
    return 0
  fi

  return 1
}

notification_data() {
  python3 - "$db_path" "$cutoff_file" "$1" <<'PYTHON'
import json
import os
import plistlib
import sqlite3
import sys
import time

CF_UNIX_OFFSET = 978307200

db_path, cutoff_file, mode = sys.argv[1:4]

try:
    with open(cutoff_file, "r", encoding="utf-8") as file:
        cutoff = float(file.read().strip() or 0)
except (FileNotFoundError, ValueError):
    cutoff = 0

if not os.path.exists(db_path):
    if mode == "count":
        print(0)
    else:
        print("0")
        print("Notification Database Not Found")
    sys.exit(0)

query = """
    select app.identifier, record.data, record.delivered_date
    from record
    join app using(app_id)
    where record.delivered_date > ?
      and record.data is not null
    order by record.delivered_date desc
"""

try:
    db_uri = "file:" + os.path.abspath(db_path) + "?mode=ro"
    connection = sqlite3.connect(db_uri, uri=True, timeout=0.2)
    try:
        rows = connection.execute(query, (cutoff,)).fetchall()
    finally:
        connection.close()
except sqlite3.Error as error:
    if mode == "count":
        print(0)
    else:
        print("0")
        print("Could Not Read Notifications")
    sys.exit(0)

def app_name(identifier):
    bundle = identifier.split(":")[-1]
    return bundle.rsplit(".", 1)[-1].replace("-", " ").replace("_", " ").title() or identifier

def truncate(text, limit):
    if len(text) <= limit:
        return text
    return text[:max(0, limit - 3)].rstrip() + "..."

notifications = []
for identifier, data, delivered_date in rows:
    try:
        payload = plistlib.loads(data)
    except Exception:
        continue

    request = payload.get("req", {})
    title = str(request.get("titl") or "").strip()
    subtitle = str(request.get("subt") or "").strip()
    body = str(request.get("body") or "").strip()
    text = " - ".join(part for part in (title, subtitle, body) if part)
    if not text:
        text = "Notification"

    notifications.append({
        "app": app_name(identifier or "Unknown"),
        "text": " ".join(text.split()),
        "delivered_date": delivered_date,
    })

if mode == "count":
    print(len(notifications))
    sys.exit(0)

if not notifications:
    print("0")
    print("No Notifications")
    sys.exit(0)

recent = notifications[:10]
grouped = {}
for notification in recent:
    grouped.setdefault(notification["app"], []).append(notification)

lines = ["By App:"]
for app in sorted(grouped):
    lines.append(f"{app}: {len(grouped[app])}")

lines.append("")
lines.append("Recent:")
for notification in recent:
    clock = time.strftime("%H:%M", time.localtime(notification["delivered_date"] + CF_UNIX_OFFSET))
    lines.append(f"{clock}  {notification['app']}: {truncate(notification['text'], 90)}")

lines.append("")
lines.append(f"Showing {len(recent)} of {len(notifications)} Notifications Since Last Notified")

if len(recent) < len(notifications):
    lines.append("Only the 10 Most Recent Notifications are Shown")

print(len(notifications))
print("\n".join(lines).rstrip())
PYTHON
}

update_item() {
  count="$(notification_data count)"

  color="$NOTIFICATIONS_INACTIVE"
  icon="􀋚"
  label_drawing=off
  label=""

  if [ "$count" -gt 0 ] 2>/dev/null; then
    color="$NOTIFICATIONS_ACTIVE"
    icon="􀝗"
  fi

  sketchybar --set "${NAME:-notifications}" \
    icon="$icon" \
    icon.color="$color" \
    label="$label" \
    label.color="$color" \
    label.drawing="$label_drawing"
}

show_dialog() {
  acquire_dialog_lock || exit 0

  output="$(notification_data list)"
  count="$(echo "$output" | sed -n '1p')"
  message="$(echo "$output" | sed '1d')"

  if [ ${#message} -gt 3000 ]; then
    message="${message:0:2997}..."
  fi

  button="$(
    osascript - "$count" "$message" <<'APPLESCRIPT'
on run argv
  set notificationCount to item 1 of argv
  set dialogText to item 2 of argv
  if notificationCount as integer is greater than 0 then
    set dialogButtons to {"Notified", "OK"}
  else
    set dialogButtons to {"OK"}
  end if
  set dialogResult to display dialog dialogText with title "Notifications (" & notificationCount & ")" buttons dialogButtons default button "OK"
  return button returned of dialogResult
end run
APPLESCRIPT
  )"

  if [ "$button" = "Notified" ]; then
    python3 - "$cutoff_file" <<'PYTHON'
import os
import sys
import time

cutoff_file = sys.argv[1]
os.makedirs(os.path.dirname(cutoff_file), exist_ok=True)
with open(cutoff_file, "w", encoding="utf-8") as file:
    file.write(str(time.time() - 978307200))
PYTHON
    update_item
  fi
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  update_item
fi
