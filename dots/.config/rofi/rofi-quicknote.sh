#!/usr/bin/env bash

# --- Configuration ---
OBSIDIAN_DAILY_NOTES_PATH="$HOME/obsidian/holocron/000-Zettelkasten"
DAILY_NOTE_PREFIX=""
DAILY_NOTE_SUFFIX=".md"
QUICK_NOTE_PREFIX="- "
QUICK_NOTE_TODO_PREFIX="- [ ] "
ROFI_CONFIG_PATH="$HOME/Projects/dotfiles/dots/.config/rofi/config-quicknote.rasi"
# --- End Configuration ---

# Launch Rofi with the custom configuration
QUICK_NOTE=$(rofi -config "$ROFI_CONFIG_PATH" -dmenu -p "Quick Note:" -i)

# Check if the user cancelled (empty input)
if [ -z "$QUICK_NOTE" ]; then
  exit 0  # Exit gracefully if cancelled
fi

# Get the current date in DD-MM-YYYY format
CURRENT_DATE=$(date +%d-%m-%Y)

# Construct the daily note filename
DAILY_NOTE_FILE="$OBSIDIAN_DAILY_NOTES_PATH/${CURRENT_DATE}${DAILY_NOTE_SUFFIX}"

# Create the directory if it doesn't exist
mkdir -p "$OBSIDIAN_DAILY_NOTES_PATH"

# Check if the file exists, create it if it doesn't
if [ ! -f "$DAILY_NOTE_FILE" ]; then
  touch "$DAILY_NOTE_FILE"
fi

if [[ "${QUICK_NOTE,,}" =~ ^todo ]]; then
  PREFIX="${QUICK_NOTE_TODO_PREFIX}"
  QUICK_NOTE=$(sed 's/^[Tt][Oo][Dd][Oo]//' <<< "$QUICK_NOTE") # Remove "todo"
  QUICK_NOTE=$(sed 's/^ *//' <<< "$QUICK_NOTE") # Remove leading spaces
else
  PREFIX="${QUICK_NOTE_PREFIX}"
fi

# Append the quick note to the daily note file
printf "\n${PREFIX}%s" "$QUICK_NOTE" >> "$DAILY_NOTE_FILE"

echo "Quick note added to: $DAILY_NOTE_FILE"
