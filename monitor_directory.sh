#!/bin/bash

# Set the path to the desired directory
TARGET_DIR="/pfad/zum/verzeichnis"
UPLOAD_TIMES_FILE="$TARGET_DIR/upload_times.txt"

# Create upload_times.txt if not existing
if [ ! -f "$UPLOAD_TIMES_FILE" ]; then
  touch "$UPLOAD_TIMES_FILE"
fi

# Function to add filenames and upload times to upload_times.txt
add_file_to_upload_times() {
  local filename=$1
  local timestamp=$(date +%s)
  echo "$filename $timestamp" >> "$UPLOAD_TIMES_FILE"
}

# Watch the directory for new files and add them to upload_times.txt
inotifywait -m -r -e create -e moved_to --format '%w%f' "$TARGET_DIR" | while read -r new_file; do
  if [ -f "$new_file" ]; then
    add_file_to_upload_times "$new_file"
    echo "Hinzugefügt: $new_file"
  fi
done
