#!/bin/sh

SCRIPTS_DIR="$(dirname "$0")/scripts"

# Clear the terminal screen
clear

# Center the text
cols=$(tput cols)
title="                                 _)  _)"
subtitle1="   _ \   __ \   \ \   /    _ \    |   |"
subtitle2="   __/   |   |   \ \ /    (   |   |   |"
subtitle3=" \___|  _|  _|    \_/    \___/   _|  _|"
welcome="Welcome to the envoii application platform setup, please select a script to run."

# Print the centered title and subtitles
printf "\n%*s\n\n" $(((${#title} + cols) / 2)) "$title"
printf "%*s\n" $(((${#subtitle1} + cols) / 2)) "$subtitle1"
printf "%*s\n" $(((${#subtitle2} + cols) / 2)) "$subtitle2"
printf "%*s\n\n\n" $(((${#subtitle3} + cols) / 2)) "$subtitle3"
printf "%*s\n\n\n" $(((${#welcome} + cols) / 2)) "$welcome"

# List available scripts
scripts=$(ls "$SCRIPTS_DIR"/*.sh)
script_names=""
for script in $scripts; do
    script_names="$script_names $(basename "$script" .sh)"
done

# Display options
echo "Please select a script to run:"
i=1
for script_name in $script_names; do
    echo "$i) $script_name"
    i=$((i+1))
done
exit_option=$((i))
echo "$exit_option) exit"

# Read user input
echo "Enter the number of the script to run: "
read choice

# Validate input and run the selected script
if [ "$choice" -gt 0 ] && [ "$choice" -le "$exit_option" ]; then
    if [ "$choice" -eq "$exit_option" ]; then
        echo "Exiting."
        exit 0
    fi
    selected_script=$(echo "$scripts" | sed -n "${choice}p")
    # echo "Running $selected_script..."
    sh "$selected_script"
else
    echo "Invalid selection. Exiting."
    exit 1
fi
