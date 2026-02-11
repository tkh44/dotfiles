#!/bin/bash

input=$(cat)

# Extract data from JSON
dir=$(echo "$input" | jq -r '.workspace.current_dir // ""')
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')

# Use current_usage (actual context state) not cumulative totals
# After compaction, current_usage reflects the compressed context
input_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')

# Calculate token usage - input + cache reads = actual context consumption
total_tokens=$((input_tokens + cache_read))
if [ "$context_size" -gt 0 ]; then
    percent=$((total_tokens * 100 / context_size))
else
    percent=0
fi

# Format token counts (K for thousands)
format_tokens() {
    local n=$1
    if [ "$n" -ge 1000 ]; then
        echo "$((n / 1000))K"
    else
        echo "$n"
    fi
}

total_fmt=$(format_tokens $total_tokens)
context_fmt=$(format_tokens $context_size)

# Get git branch (if in repo)
git_branch=""
if [ -n "$dir" ] && [ -d "$dir" ]; then
    git_branch=$(cd "$dir" 2>/dev/null && git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
fi

# Shorten directory: ~/last/two/parts
short_dir="${dir/#$HOME/~}"
# Get last 2 path components but keep ~/
# Remove leading ~ for splitting, then add it back
temp_dir="${short_dir/#\~/}"
IFS='/' read -ra parts <<< "$temp_dir"
num_parts=${#parts[@]}
if [ "$num_parts" -gt 2 ]; then
    short_dir="~/${parts[$((num_parts-2))]}/${parts[$((num_parts-1))]}"
elif [[ "$short_dir" != ~* ]]; then
    short_dir="~/$short_dir"
fi

# Color codes
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
CYAN='\033[36m'
MAGENTA='\033[35m'
BLUE='\033[34m'
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

# interpolateCool: true color gradient (cyan -> blue -> purple -> magenta)
# Gradient stops: cyan(0, 255, 255) -> blue(66, 135, 245) -> purple(147, 51, 234) -> magenta(236, 72, 153)

interpolateCool() {
    local pos=$1  # 0-100
    local r g b

    if [ "$pos" -lt 33 ]; then
        # cyan to blue (0-33%)
        local t=$((pos * 100 / 33))
        r=$((0 + (66 - 0) * t / 100))
        g=$((255 + (135 - 255) * t / 100))
        b=$((255 + (245 - 255) * t / 100))
    elif [ "$pos" -lt 66 ]; then
        # blue to purple (33-66%)
        local t=$(((pos - 33) * 100 / 33))
        r=$((66 + (147 - 66) * t / 100))
        g=$((135 + (51 - 135) * t / 100))
        b=$((245 + (234 - 245) * t / 100))
    else
        # purple to magenta (66-100%)
        local t=$(((pos - 66) * 100 / 34))
        r=$((147 + (236 - 147) * t / 100))
        g=$((51 + (72 - 51) * t / 100))
        b=$((234 + (153 - 234) * t / 100))
    fi

    printf '\033[38;2;%d;%d;%dm' "$r" "$g" "$b"
}

# Partial block characters (1/8 increments)
partial_blocks=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉" "█")

# Build powerline progress bar with sub-block precision
bar_length=10
total_units=$((bar_length * 8))  # 80 units for 10 blocks
filled_units=$((percent * total_units / 100))
[ "$filled_units" -gt "$total_units" ] && filled_units=$total_units
[ "$filled_units" -lt 0 ] && filled_units=0

# Build the bar with true color gradient
bar=""
for ((i=0; i<bar_length; i++)); do
    block_start=$((i * 8))
    block_end=$(((i + 1) * 8))

    # Calculate color position for this block (0-100)
    color_pos=$((i * 100 / bar_length))
    color_code=$(interpolateCool $color_pos)

    if [ "$filled_units" -ge "$block_end" ]; then
        # Full block
        bar+="${color_code}█"
    elif [ "$filled_units" -le "$block_start" ]; then
        # Empty block
        bar+="${DIM}░"
    else
        # Partial block
        partial=$((filled_units - block_start))
        bar+="${color_code}${partial_blocks[$partial]}"
    fi
done
bar+="${RESET}"

# Build the status line
output=""
output+="${BLUE}${short_dir}${RESET}"

if [ -n "$git_branch" ]; then
    output+=" ${MAGENTA} ${git_branch}${RESET}"
fi

# Get start/end colors for arrows
start_color=$(interpolateCool 0)
end_color=$(interpolateCool 100)
output+=" ${start_color}${RESET}${bar}${end_color}${RESET}"
output+=" ${DIM}${percent}%${RESET}"

printf '%b' "$output"
