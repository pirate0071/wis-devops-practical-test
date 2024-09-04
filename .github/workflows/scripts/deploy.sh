#!/bin/bash
set -e

EXCLUDE_LIST=(
  ".git"
  "pipeline"
  "vendor"
  "node_modules"
  ".github"
  "sonar-project.properties"
  "README.md"
  "gulpfile.js"
)

# Check if db name environment variables are set
if [ -z "$DB_NAME" ]; then
  echo "Error: DB_NAME is not set."
  exit 1
fi

# Check if db user environment variables are set
if [ -z "$DB_USER" ]; then
  echo "Error: DB_USER is not set."
  exit 1
fi

# Check if db password environment variables are set
if [ -z "$DB_PASSWORD" ]; then
  echo "Error: DB_PASSWORD is not set."
  exit 1
fi

echo "Updating wp-config.php with environment variables..."
# Replace placeholders in wp-config.php with GitHub Secrets
sed -i "s/DB_NAME_VALUE/${DB_NAME}/g" ./artifacts/wp-config.php
sed -i "s/DB_USER_VALUE/${DB_USER}/g" ./artifacts/wp-config.php
sed -i "s/DB_PASSWORD_VALUE/${DB_PASSWORD}/g" ./artifacts/wp-config.php

# Check if server user environment variables are set
if [ -z "$SSH_USER" ]; then
  echo "Error: SSH_USER is not set."
  exit 1
fi

# Check if server host environment variables are set
if [ -z "$SSH_HOST" ]; then
  echo "Error: SSH_HOST is not set."
  exit 1
fi

# Check if server key environment variables are set
if [ -z "$SSH_KEY" ]; then
  echo "Error: SSH_KEY is not set."
  exit 1
fi

# Check if server port environment variables are set
if [ -z "$SSH_PORT" ]; then
  echo "Error: SSH_PORT is not set."
  exit 1
fi

# Check if deploy path environment variables are set
if [ -z "$DEPLOY_PATH" ]; then
  echo "Error: DEPLOY_PATH is not set."
  exit 1
fi

if command -v sshpass >/dev/null 2>&1; then
    echo "sshpass is already installed."
else
    echo "sshpass is not installed. Installing sshpass..."
    sudo apt-get update && sudo apt-get install -y sshpass
fi

echo "Deploying with rsync..."
sshpass -p "$SSH_KEY" rsync -rvz -e "ssh -p $SSH_PORT -o StrictHostKeyChecking=no" --progress "${EXCLUDE_LIST[@]/#/--exclude=}" ./artifacts/ ${SSH_USER}@${SSH_HOST}:${DEPLOY_PATH}
