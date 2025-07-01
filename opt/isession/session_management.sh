#!/bin/bash
# Shared Variables System Core

SHARED_VARS_FILE="$HOME/vars"
CMD_DEPTH=0

update() {
    source "$SHARED_VARS_FILE" 2>/dev/null
}

user_assign() {
    # Skip if inside complex command structure
    (( CMD_DEPTH > 0 )) && return
    
    # Skip if in subshell
    [[ $BASH_SUBSHELL -ne 0 ]] && return

    # Extract and clean first word
    local first_word="${BASH_COMMAND%%=*}"
    first_word="${first_word#"${first_word%%[![:space:]]*}"}"  # Trim leading spaces
    first_word="${first_word%%[[:space:]]*}"                   # Trim trailing spaces

    # Skip special variables and built-ins
    if [[ ! "$first_word" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]] ||
       [[ "$first_word" =~ ^(local|declare|typeset|export|readonly|PROMPT_COMMAND)$ ]]; then
        return
    fi

    # Verify strict assignment pattern
    if [[ "$BASH_COMMAND" =~ ^[[:space:]]*[a-zA-Z_][a-zA-Z0-9_]*=[^[:space:]] ]]; then
        echo "export $BASH_COMMAND" >> "$SHARED_VARS_FILE"
        echo "User assignment detected: $BASH_COMMAND"
    fi
}

initialize_shared_vars() {
    [[ -f "$SHARED_VARS_FILE" ]] && source "$SHARED_VARS_FILE"
    
    # Set up DEBUG trap with depth tracking
    trap 'case $BASH_COMMAND in 
            *"{"*|*"}"*|*if*|*then*|*else*|*fi*|*for*|*do*|*done*|*while*|*until*|*select*|*case*|*esac*) 
                ((CMD_DEPTH++)) ;;
          esac;
          user_assign;
          case $BASH_COMMAND in 
            *"}"*|*fi*|*done*|*esac*) 
                ((CMD_DEPTH--)) ;;
          esac;
          update' DEBUG
}
