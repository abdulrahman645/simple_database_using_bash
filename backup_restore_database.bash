#!/bin/bash

echo "Databases available for creating tables:"
for database in Databases/*; do
  if [ -d "$database" ] && [ -w "$database" ]; then
    echo "$(basename "$database")"
  fi
done

backup_all_databases() {
    read -p "Enter the backup schedule (daily, weekly, or monthly): " schedule
    read -p "Enter the compression mode (zip, tar, or gzip): " compression

    if [ "$schedule" = "daily" ] || [ "$schedule" = "weekly" ] || [ "$schedule" = "monthly" ]; then
        backup_dir="/opt/backups/$(date +'%Y-%m-%d')"
        mkdir -p "$backup_dir"
        for db in Databases/*; do
            case $compression in
                zip)
                    zip -r "$backup_dir"/"$db".zip "$db"
                    ;;
                tar)
                    tar -cvf "$backup_dir"/"$db".tar "$db"
                    ;;
                gzip)
                    tar -czvf "$backup_dir"/"$db".tar.gz "$db"
                    ;;
                *)
                    echo "Invalid compression mode. Please choose zip, tar, or gzip."
                    exit 1
                    ;;
            esac
        done
        echo "Backup completed successfully."
    else
        echo "Invalid backup schedule. Please choose daily, weekly, or monthly."
        exit 1
    fi
}

backup_updated_databases() {
    read -p "Enter the date (YYYY-MM-DD) to backup databases updated on that date: " backup_date
    read -p "Enter the compression mode (zip, tar, or gzip): " compression

    backup_dir="/opt/backups/updated_on_$backup_date"
    mkdir -p "$backup_dir"
    for db in Databases/*; do
        if [ "$(stat -c %y "$db" | cut -d ' ' -f1)" = "$backup_date" ]; then
            case $compression in
                zip)
                    zip -r "$backup_dir"/"$db".zip "$db"
                    ;;
                tar)
                    tar -cvf "$backup_dir"/"$db".tar "$db"
                    ;;
                gzip)
                    tar -czvf "$backup_dir"/"$db".tar.gz "$db"
                    ;;
                *)
                    echo "Invalid compression mode. Please choose zip, tar, or gzip."
                    exit 1
                    ;;
            esac
        fi
    done
    echo "Backup completed successfully."
}

rotate_backups_by_date() {
    find /opt/backups/* -type d -prune -mtime +5 -exec rm -rf {} \;
    echo "Backups rotated based on date."
}

rotate_backups_by_size() {
    read -p "Enter the threshold size for backups (in MB): " threshold_size

    current_size=$(du -c /opt/backups | grep total | awk '{print $1}')
    while [ $current_size -gt $threshold_size ]; do
        oldest_backup=$(ls -t /opt/backups | tail -1)
        rm -rf /opt/backups/"$oldest_backup"
        current_size=$(du -c /opt/backups | grep total | awk '{print $1}')
    done
    echo "Backups rotated based on size."
}

read -p "Choose an operation (backup_all, backup_updated, rotate_by_date, rotate_by_size): " operation

case $operation in
    backup_all)
        backup_all_databases
        ;;
    backup_updated)
        backup_updated_databases
        ;;
    rotate_by_date)
        rotate_backups_by_date
        ;;
    rotate_by_size)
        rotate_backups_by_size
        ;;
    *)
        echo "Invalid operation. Please choose backup_all, backup_updated, rotate_by_date, or rotate_by_size."
        exit 1
        ;;
esac
