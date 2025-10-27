#!/bin/bash

# MySQL parameters
user="root"
password="12345"
host="127.0.0.1"
db_name="fin"

# Backup paths
backup_path="/var/backups"
local_backup_path="/home/asus/projects/dumps/fin"
drbx_path="/home/asus/Dropbox/HomeTools/"
date=$(date +%d_%m_%Y)
filename="$backup_path/$date.sql.gz"

# Check if the backup folder exists, if not, create it
if [ ! -d "$backup_path" ]; then
    mkdir -p "$backup_path"
fi

# Function to check if the container is running
is_container_running() {
    docker inspect -f '{{.State.Running}}' od-mysql 2>/dev/null
}

# Start the container if it's not running
if [ "$(is_container_running)" != "true" ]; then
    echo "Starting the od-mysql container..."
    docker start od-mysql
    # Wait for a few seconds to ensure the container is fully started
    sleep 10
fi

# Use mysqldump utility to backup our database
docker exec -it od-mysql bash -c "mysqldump --user=$user --password=$password --host=$host $db_name | gzip > $filename 2>$backup_path/fin_backup_error.log"

# Copy the backup to the Dropbox path
cp "$local_backup_path/$date.sql.gz" "$drbx_path"

