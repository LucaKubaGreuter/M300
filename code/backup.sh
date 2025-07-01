#!/bin/bash

BACKUP_DATE=$(date +%F)
APP_DIR="/home/azureuser/weather-app"
DUMP_FILE="/tmp/weatherapp_dump_${BACKUP_DATE}.tar.gz"
STORAGE_ACCOUNT="stweatherapp"
CONTAINER="backup"

SAS_KEY=$(cat /home/azureuser/SAS_key.txt)

tar czf "$DUMP_FILE" -C "$APP_DIR" .

BLOB_URL="https://${STORAGE_ACCOUNT}.blob.core.windows.net/${CONTAINER}/${DUMP_FILE##*/}?${SAS_KEY}"
echo "Blob-URL: $BLOB_URL"

azcopy copy "$DUMP_FILE" "$BLOB_URL"
echo "Backup erfolgreich nach Azure Storage hochgeladen!"