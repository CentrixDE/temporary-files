#!/bin/bash

# Set the path to the desired directory
TARGET_DIR="/path/to/directory"
UPLOAD_TIMES_FILE="$TARGET_DIR/upload_times.txt"
TEMP_FILE="$TARGET_DIR/temp.txt"

# Function to delete files older than 4 weeks
delete_old_files() {
  local filename=$1
  local timestamp=$2
  local current_timestamp=$(date +%s)
  local four_weeks_in_seconds=$((4*7*24*60*60))

  if (( current_timestamp - timestamp > four_weeks_in_seconds )); then
    if [ -f "$filename" ]; then
      rm "$filename"
      echo "Deleted: $filename"
    fi
  else
    echo "$filename $timestamp" >> "$TEMP_FILE"
  fi
}

# Check each file in the upload_times.txt file and delete it if it's older than 4 weeks
while read -r line; do
  filename=$(echo "$line" | cut -d' ' -f1)
  timestamp=$(echo "$line" | cut -d' ' -f2)

  delete_old_files "$filename" "$timestamp"
done < "$UPLOAD_TIMES_FILE"

# Replace the upload_times.txt file with the temp file
mv "$TEMP_FILE" "$UPLOAD_TIMES_FILE"
