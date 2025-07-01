#!/bin/bash
# Shared Variables System Core

SHARED_VARS_FILE="$HOME/vars"

update() {
    source "$SHARED_VARS_FILE" 2>/dev/null
}

user_assign() {
    # Check if command matches simple variable assignment pattern
    if [[ "$BASH_COMMAND" =~ ^[[:space:]]*[a-zA-Z_][a-zA-Z0-9_]*= ]] && 
       [[ ! "$BASH_COMMAND" =~ PROMPT_COMMAND ]]; then
        echo "export $BASH_COMMAND" >> "$SHARED_VARS_FILE"
        echo "User assignment detected: $BASH_COMMAND"
    fi
}

initialize_shared_vars() {
    # Initialize variables
    [[ -f "$SHARED_VARS_FILE" ]] && source "$SHARED_VARS_FILE"
    
    # Set up DEBUG trap
    trap 'user_assign; update' DEBUG
}
