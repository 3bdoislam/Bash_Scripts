#!/bin/bash

# Configuration
source_directory="/home"
backup_filename="backup_$(date +"%Y%m%d_%H%M%S").tar.gz"
backup_log="/var/log/backup.log"

# Perform backup using tar
tar -czf "$backup_filename" -C "$source_directory" .

# Check tar exit status
if [ $? -eq 0 ]; then
    echo "Backup completed successfully: $backup_filename" >> "$backup_log"
else
    echo "Backup failed on $(date): $backup_filename" >> "$backup_log"
fi