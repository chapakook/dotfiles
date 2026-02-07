#!/bin/bash
# Claude Code completion notification script

# Read hook input from stdin
input=$(cat)

# Extract transcript_path from JSON input
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')

if [[ -n "$transcript_path" && -f "$transcript_path" ]]; then
    # Get the last user message from transcript
    last_prompt=$(jq -r 'select(.type == "human") | .message.content[]? | select(type == "string") // select(.type == "text") | .text // .' "$transcript_path" 2>/dev/null | tail -1 | head -c 50)

    if [[ -z "$last_prompt" ]]; then
        last_prompt="작업"
    fi
else
    last_prompt="작업"
fi

# Truncate if too long and add ellipsis
if [[ ${#last_prompt} -ge 50 ]]; then
    last_prompt="${last_prompt}..."
fi

# Send macOS notification with terminal-notifier
# -activate: opens iTerm when notification is clicked
terminal-notifier \
    -title "Claude Code" \
    -message "${last_prompt} 작업이 완료되었습니다." \
    -activate com.googlecode.iterm2 \
    -sound default
