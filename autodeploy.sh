#!/bin/bash

DEST_DIR="$HOME/Downloads"
REPO_DIR="$DEST_DIR/Auto-Deploy-Test"
SCRIPT_PATH="$(realpath "$0")"
LOG_FILE="DEBUG_LOG.txt"

# Clone or update the repository
if [ ! -d "$REPO_DIR/.git" ]; then
    git clone https://github.com/SharkenFunGithub/Auto-Deploy-Test.git "$REPO_DIR"
    cd "$REPO_DIR"
    git remote set-url origin git@github.com:SharkenFunGithub/Auto-Deploy-Test.git
    echo "$(date) Repository cloned and SSH remote set." >> "$LOG_FILE"
else
    cd "$REPO_DIR" || exit 1
    git remote set-url origin git@github.com:SharkenFunGithub/Auto-Deploy-Test.git
    echo "Running git pull..." >> "$LOG_FILE"
    git pull >> "$LOG_FILE" 2>&1
    echo "$(date) Repository pulled." >> "$LOG_FILE"
fi

echo "$(date) This Website has been regularly updated to the lastest version" >> update_log.txt

read -p "Do you want to set this script to auto-run every 2 minutes? (y/n): " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    CRON_JOB="*/2 * * * * /bin/bash $SCRIPT_PATH"
    if ! crontab -l 2>/dev/null | grep -F "$SCRIPT_PATH" >/dev/null; then
        (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
        echo "Cron job added to run every 2 minutes. Type 'crontab -e' in the Terminal to edit the time automation or delete the line to end the automation"
    else
        echo "Cron job already exists."
    fi
else
    echo "Automation skipped."
fi
