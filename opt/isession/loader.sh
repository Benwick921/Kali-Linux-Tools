#!/bin/bash
# Shared Variables Loader

SESSION_FOLDER="$HOME/.config/isession"
SESSIONFILE="$SESSION_FOLDER/default-session"

# Create directory if it doesn't exist
if [ ! -d "$SESSION_FOLDER" ]; then
    mkdir -p "$SESSION_FOLDER"
fi

# Create file if it doesn't exist
if [ ! -f "$SESSIONFILE" ]; then
    touch "$SESSIONFILE"
    echo "Created file: $SESSIONFILE"
fi
# Source core system
source /opt/isession/session_management.sh $SESSIONFILE

# Initialize the system
initialize_shared_vars 
