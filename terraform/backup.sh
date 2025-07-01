#!/bin/bash

BACKUP_DATE=$(date +%F)
APP_DIR="/home/azureuser/weather-app"
DUMP_FILE="/tmp/weatherapp_dump_${BACKUP_DATE}.tar.gz"
STORAGE_ACCOUNT="stweatherapp"
CONTAINER="backup"

# SAS-Key einlesen (Query-String, z.B. ?sv=...)
SAS_KEY=$(cat /home/azureuser/SAS_key.txt)

# Archiv erstellen
tar czf "$DUMP_FILE" -C "$APP_DIR" .

# Upload-URL zusammenbauen
BLOB_URL="https://${STORAGE_ACCOUNT}.blob.core.windows.net/${CONTAINER}/${DUMP_FILE##*/}?${SAS_KEY}"

# Upload mit azcopy
azcopy copy "$DUMP_FILE" "$BLOB_URL"
echo "Backup erfolgreich nach Azure Storage hochgeladen!"
