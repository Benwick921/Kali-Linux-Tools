# Add to your ~/.bashrc
if [[ $- == *i* ]]; then  # Only run in interactive shells
    if [ -z "$__print_chars_initialized" ]; then
        __print_chars_initialized=1

		
        # Variables for suggestion tracking
        __last_suggestion=""
        __last_suggestion_length=0
        __last_additional_lines=0	

		get_suggestion_suffix() {
			local input="$READLINE_LINE"
			local match

			# Reverse the history and look for the first line
			# whose first N characters (N=length of input) match input, case‑insensitive
			match=$(
			  tac "$HOME/.bash_history" | \
			  awk -v pat="$input" '
				BEGIN { IGNORECASE = 1; L = length(pat) }
				substr($0,1,L) == pat { print; exit }
			  '
			)

			# If we got a match and it's not exactly what the user typed, return its suffix
			if [[ -n "$match" && "$match" != "$input" ]]; then
				echo -n "${match:${#input}}"
			fi
		}

		show_suggestion() {
			local input="${READLINE_LINE}"
			local suggestion=$(get_suggestion_suffix)

			local GREY='\033[90m'
			local RESET='\033[0m'

			if [[ -z "$suggestion" || "$suggestion" == "$input" ]]; then
				return
			fi

			local suffix="${suggestion#$input}"

			# Save cursor position (modern)
			echo -ne "\033[s"

			# Move to beginning of current line and clear it
			echo -ne "\033[2K\r"

			# Redraw the prompt manually
			# Mimic only the last line of your PS1: └─$
			printf "└─$ %s${GREY}%s${RESET}" "$input" "$suffix"

			# Restore cursor to where the user left off
			echo -ne "\033[u"
			#show_additional_suggestions "$input" "$suggestio"
		}


		autocomplete_suggestion() {
			local input="$READLINE_LINE"
			local full

			# Find the most recent history entry that literally starts with $input
			full=$(
			  tac "$HOME/.bash_history" | \
			  awk -v pat="$input" '
				BEGIN { IGNORECASE = 1; L = length(pat) }
				substr($0, 1, L) == pat { print; exit }
			  '
			)

			# If we found a longer match, commit its suffix
			if [[ -n "$full" && "$full" != "$input" ]]; then
				local suffix="${full:${#input}}"
				READLINE_LINE="${input}${suffix}"
				READLINE_POINT=${#READLINE_LINE}
			fi
		}

        # Function to handle character insertion
        insert_char() {
            local char="$1"
            local cursor_pos=${READLINE_POINT:-0}
            
            # Insert character into command line
            READLINE_LINE="${READLINE_LINE:0:$cursor_pos}$char${READLINE_LINE:$cursor_pos}"
            READLINE_POINT=$((cursor_pos + ${#char}))
            
            # Show command suggestions
            show_suggestion
        }

        # Function to handle backspace
        handle_backspace() {
            local cursor_pos=${READLINE_POINT:-0}
            if [ $cursor_pos -gt 0 ]; then
                # Remove character before cursor
                READLINE_LINE="${READLINE_LINE:0:$((cursor_pos-1))}${READLINE_LINE:$cursor_pos}"
                READLINE_POINT=$((cursor_pos-1))
                
                # Show command suggestions
                show_suggestion
            fi
        }

        # Function to handle delete
        handle_delete() {
            local cursor_pos=${READLINE_POINT:-0}
            local line_length=${#READLINE_LINE}
            if [ $cursor_pos -lt $line_length ]; then
                # Remove character at cursor
                READLINE_LINE="${READLINE_LINE:0:$cursor_pos}${READLINE_LINE:$((cursor_pos+1))}"
                
                # Show command suggestions
                show_suggestion
            fi
        }
        
        
        
		bind -x '"\C-@":autocomplete_suggestion'
        # Bind delete key
        bind -x '"\e[3~":"handle_delete"' 2>/dev/null
        
        # Comprehensive backspace bindings
        bind -x '"\x08":"handle_backspace"' 2>/dev/null
        bind -x '"\b":"handle_backspace"' 2>/dev/null
        bind -x '"\C-h":"handle_backspace"' 2>/dev/null
        bind -x '"\x7f":"handle_backspace"' 2>/dev/null
        bind -x '"\C-?":"handle_backspace"' 2>/dev/null

        # Bind alphabetic characters (a-z)
        for char in {a..z}; do
            bind -x "\"$char\":\"insert_char '$char'\"" 2>/dev/null
            bind -x "\"$(echo $char | tr '[:lower:]' '[:upper:]')\":\"insert_char '$(echo $char | tr '[:lower:]' '[:upper:]')'\"" 2>/dev/null
        done
        
        # Bind numbers (0-9)
        for char in {0..9}; do
            bind -x "\"$char\":\"insert_char '$char'\"" 2>/dev/null
        done
        
				symbols='~!@#$%^&*()_-+={}[]|\\:;\"<>,.?/ '
		for ((i=0; i<${#symbols}; i++)); do
			ch="${symbols:i:1}"
			# escape backslash and double‑quote for the bind command
			case "$ch" in
			  '\' ) esc='\\'   ;;
			  '"' ) esc='\"'   ;;
			  ' ' ) esc=' '    ;;
			  *)    esc="$ch"  ;;
			esac
			bind -x "\"$esc\":\"insert_char '$ch'\"" 2>/dev/null
		done
		#source $HOME/multi-suggester.sh
    fi
fi
