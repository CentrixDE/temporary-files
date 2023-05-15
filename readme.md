# Directory Monitor and File Cleaner Scripts

This repository contains two bash scripts:

1. `monitor_directory.sh`: Monitors a specified directory for new files and logs their creation or move time.
2. `clean_directory.sh`: Deletes files listed in the log file that are older than 4 weeks and updates the log file.

## monitor_directory.sh
This script monitors a specified directory for any new files and logs the time of their creation or movement into the directory. The script uses the `inotifywait` command to watch for file system events.

### Usage
1. Replace `"/path/to/directory"` in the script with the actual path to the directory you want to monitor.
2. Make the script executable using the command `sudo chmod +x monitor_directory.sh`.
3. Run the script using the command `./monitor_directory.sh`.

The script will keep running and monitoring the directory until you stop it. To stop the script, you can press `Ctrl+C` in the terminal. If you want the script to run in the background even after you close the terminal, you can use the `nohup` command: `nohup ./monitor_directory.sh &` or by using the `screen` package.

## clean_directory.sh
This script deletes files that are listed in the log file and are older than 4 weeks. It also updates the log file to remove entries for deleted files.

### Usage
1. Replace `"/path/to/directory"` in the script with the actual path to the directory you want to clean.
2. Make the script executable using the command `sudo chmod +x clean_directory.sh`.
3. Run the script using the command `./clean_directory.sh`.

The script will check each file in the log file and delete it if it's older than 4 weeks. After all files have been checked, the log file is replaced with a temporary file, which only contains entries for files that still exist and are less than 4 weeks old. To have it run regurarily you can add the script as a cronjob.

## Dependencies
The `inotifywait` command used in `monitor_directory.sh` is part of the `inotify-tools` package. If it's not installed on your system, you can install it using your system's package manager (e.g., `sudo apt-get install inotify-tools` on Ubuntu).