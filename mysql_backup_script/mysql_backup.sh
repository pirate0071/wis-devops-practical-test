#!/bin/bash
# ==============================================================================
# MySQL Backup Script
# ==============================================================================
# Description:
# This script automates the process of creating compressed backups of MySQL
# databases. It supports local backups and provides configuration through 
# command-line arguments. Features include secure password entry, automatic 
# installation of `mysqldump`, backup retention management, and optional 
# man page generation.
#
# Features:
# - Secure password prompt
# - Mandatory command-line arguments
# - Automatic `mysqldump` installation
# - Backup retention and cleanup
#
# Manual:
# man ./mysql_backup.1
# 
# Usage:
# ./mysql_backup.sh -d db_name -u db_user -b backup_dir [-h db_host] [-P db_port]
# [-R retention_days] [-c]
#
# Example:
# ./mysql_backup.sh -d my_database -u my_user -b /my/backup/dir
#
# ==============================================================================
# Web International Services (WIS):
# ==============================================================================
# *       *       *    *       *   *       *       *
# * *   * *     *    *   *   *   *   *   *   *   *   *
# *   * *   *   *      *   *   *   *     *   *     *   *
# *   * *   *   *      *   *   *   *     *   *     *   *
# *   * *   *   *      *   *   *   *     *   *     *   *
# *   * *   *   *      *   *   *   *     *   *     *   *
# *   * *   *   *      *   *   *   *     *   *     *   *
# ==============================================================================
# Script Version: 1.0
# Last Updated: [04/09/2024]
# Author: [Montassar SMIDA]
# ==============================================================================

# Default Configuration
DB_HOST="localhost"
DB_PORT=3306
RETENTION_DAYS=7

# Date format for backup file
DATE=$(date +%F_%H-%M-%S)
BACKUP_FILE=""

# Usage information
usage() {
    echo "Usage: $0 -d db_name -u db_user -b backup_dir [-h db_host] [-P db_port] [-R retention_days] [-c]"
    echo
    echo "  -d db_name        Database name (mandatory)"
    echo "  -u db_user        Database user (mandatory)"
    echo "  -b backup_dir     Local backup directory (mandatory)"
    echo "  -h db_host        Database host (default: localhost)"
    echo "  -P db_port        Database port (default: 3306)"
    echo "  -R retention_days Number of days to keep backups (default: 7)"
    echo "  -c                Perform cleanup of old backups"
    exit 1
}

# Check if mysqldump is installed, if not install it
if ! command -v mysqldump &> /dev/null; then
    echo "mysqldump is not installed. Installing now..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install -y mysql-client
        elif command -v yum &> /dev/null; then
            sudo yum install -y mysql
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y mysql
        elif command -v pacman &> /dev/null; then
            sudo pacman -Sy mysql-clients
        else
            echo "Unsupported package manager. Please install mysqldump manually."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            brew install mysql-client
        else
            echo "Homebrew is not installed. Please install Homebrew or install mysqldump manually."
            exit 1
        fi
    else
        echo "Unsupported OS. Please install mysqldump manually."
        exit 1
    fi
fi

# Parse command-line arguments
generate_man=false
while getopts "d:u:b:h:P:R:cm" opt; do
    case $opt in
        d) DB_NAME=$OPTARG ;;
        u) DB_USER=$OPTARG ;;
        b) BACKUP_DIR=$OPTARG ;;
        h) DB_HOST=$OPTARG ;;
        P) DB_PORT=$OPTARG ;;
        R) RETENTION_DAYS=$OPTARG ;;
        c) CLEANUP=true ;;
        *) usage ;;
    esac
done

# Check for mandatory arguments
if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$BACKUP_DIR" ]; then
    echo "Error: Missing mandatory arguments."
    usage
fi

# Prompt for the password securely
read -s -p "Enter MySQL password for user $DB_USER: " DB_PASS
echo

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Define backup file path
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql.gz"

# Backup command
mysqldump -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME | gzip > $BACKUP_FILE

# Cleanup old backups
if [ "$CLEANUP" = true ]; then
    find $BACKUP_DIR -type f -mtime +$RETENTION_DAYS -name "*.gz" -exec rm {} \;
fi

echo "Backup completed: $BACKUP_FILE"