#!/bin/bash
# Neurite Backup Script
# Automated backup for Docker deployment

set -e

# Configuration
BACKUP_DIR="/app/backups"
DATA_DIR="/app/data"
LOG_DIR="/app/logs"
RETENTION_DAYS=${BACKUP_RETENTION_DAYS:-30}
BACKUP_NAME="neurite-backup-$(date +%Y%m%d-%H%M%S)"

# Create backup directory
mkdir -p "$BACKUP_DIR"

echo "Starting Neurite backup: $BACKUP_NAME"

# Create backup archive
tar -czf "$BACKUP_DIR/$BACKUP_NAME.tar.gz" \
    -C "$DATA_DIR" . \
    -C "$LOG_DIR" . 2>/dev/null || true

# Verify backup
if [ -f "$BACKUP_DIR/$BACKUP_NAME.tar.gz" ]; then
    echo "Backup created successfully: $BACKUP_NAME.tar.gz"
    
    # Get backup size
    BACKUP_SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME.tar.gz" | cut -f1)
    echo "Backup size: $BACKUP_SIZE"
else
    echo "ERROR: Backup failed!"
    exit 1
fi

# Cleanup old backups
echo "Cleaning up backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -name "neurite-backup-*.tar.gz" -type f -mtime +$RETENTION_DAYS -delete

# List current backups
echo "Current backups:"
ls -lh "$BACKUP_DIR"/neurite-backup-*.tar.gz 2>/dev/null || echo "No backups found"

echo "Backup completed successfully!"
