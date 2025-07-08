# Variables for suggestion tracking
__last_additional_lines=0
HIGHLIGHT_INDEX=2  # ← manually set this to highlight a specific suggestion

show_additional_suggestions() {
    local input="$1"
    local main_suggestion="$2"

    if [[ -z "$input" ]]; then
    	clear_suggestion_lines
        return
    fi

    # Move down to previously printed lines and clear them
    for ((i = 0; i < __last_additional_lines; i++)); do
        echo -ne "\033[E"       # Move to next line
        echo -ne "\033[2K\r"    # Clear entire line
    done

    # Move cursor back up to prompt line
    for ((i = 0; i < __last_additional_lines; i++)); do
        echo -ne "\033[F"
    done

    local MAX_ADDITIONAL=3
    local GREY='\033[90m'
    local RESET='\033[0m'
    local HIGHLIGHT='\033[7m'
    local suggestions=()
    local count=0
    local index=1

    while IFS= read -r line; do
        if [[ "${line,,}" == "${input,,}"* && "$line" != "$main_suggestion" ]]; then
            if ! [[ " ${suggestions[*]} " =~ " ${line} " ]]; then
                suggestions+=("$line")
                ((count++))
                (( count == MAX_ADDITIONAL )) && break
            fi
        fi
    done < <(tac "$HOME/.bash_history")

    if [[ ${#suggestions[@]} -eq 0 ]]; then
        __last_additional_lines=0
        return
    fi

    echo -ne "\033[s"   # Save cursor position
    echo                # Print newline after prompt

    for sug in "${suggestions[@]}"; do
        if [[ $index -eq $HIGHLIGHT_INDEX ]]; then
            printf "    ${HIGHLIGHT}${GREY}[%d] %s${RESET}\n" "$index" "$sug"
        else
            printf "    ${GREY}[%d] %s${RESET}\n" "$index" "$sug"
        fi
        ((index++))
    done

    __last_additional_lines=${#suggestions[@]}
    echo -ne "\033[u"   # Restore cursor position
}

highlight_up() {
if (( __last_additional_lines <= 1 )); then
        return  # Do nothing if there aren't multiple suggestions
    fi
	if [[ $HIGHLIGHT_INDEX > 1 ]] then
    	(( HIGHLIGHT_INDEX-- ))
    fi
    #echo $HIGHLIGHT_INDEX
    show_suggestion
}

highlight_down() {

if (( __last_additional_lines <= 1 )); then
        return  # Do nothing if there aren't multiple suggestions
    fi
	if [[ $HIGHLIGHT_INDEX < 3 ]] then
    	(( HIGHLIGHT_INDEX++ ))
    fi
    #echo $HIGHLIGHT_INDEX
    show_suggestion
}

clear_suggestion_lines() {
	if (( __last_additional_lines <= 1 )); then
        return  # Do nothing if there aren't multiple suggestions
    fi
    # Move to the current line and clear it (the prompt + inline suggestion)
    echo -ne "\033[2K\r"

    # Move down and clear additional suggestion lines (max 3 lines)
    local lines_to_clear=3
    for ((i=0; i<lines_to_clear; i++)); do
        echo -ne "\033[B\033[2K"
    done

    # Move back up to the original prompt line
    for ((i=0; i<lines_to_clear; i++)); do
        echo -ne "\033[A"
    done
}
cleanup_on_interrupt() {
	clear_suggestion_lines
	
	prompt_color='\033[;32m'
    info_color='\033[1;34m'
    
    READLINE_LINE=''
    READLINE_POINT=0
    # Print the second line of your prompt manually after clearing
    echo -ne ${prompt_color}└─$info_color$	
}

#redraw_prompt() {
#    bind -x '"\C-l": redraw_prompt'  # (Optional) allow Ctrl+L to test it
#    READLINE_LINE=$READLINE_LINE
#    READLINE_POINT=${#READLINE_LINE}
#}

multi_autocomplete_suggestion() {
    local input="$READLINE_LINE"
    local suggestions=()
    local match

    while IFS= read -r line; do
        if [[ "${line,,}" == "${input,,}"* ]]; then
            # Skip duplicates
            if [[ ! " ${suggestions[*]} " =~ " ${line} " ]]; then
                suggestions+=("$line")
            fi
        fi
    done < <(tac "$HOME/.bash_history")

    local index=$((HIGHLIGHT_INDEX - 1))
    if [[ $index -ge 0 && $index -lt ${#suggestions[@]} ]]; then
        READLINE_LINE="${suggestions[$index]}"
        READLINE_POINT=${#READLINE_LINE}
    fi
}
bind -x '"\C-@":multi_autocomplete_suggestion'  # Example: Ctrl + X



trap 'cleanup_on_interrupt' SIGINT

bind -x '"\e[1;5A": highlight_up'  # Ctrl + ↑
bind -x '"\e[1;5B": highlight_down'  # Ctrl + ↓
trap 'clear_suggestion_lines' DEBUG
