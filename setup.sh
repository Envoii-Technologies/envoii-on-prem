#!/bin/bash

SCRIPTS_DIR="/Users/envoii/Desktop/envoii-on-prem/scripts"

# Clear the terminal screen
clear

# Center the text
cols=$(tput cols)
title="                                 _)  _)"
subtitle1="   _ \   __ \   \ \   /    _ \    |   |"
subtitle2="   __/   |   |   \ \ /    (   |   |   |"
subtitle3=" \___|  _|  _|    \_/    \___/   _|  _|"
welcome="Welcome to the envoii application platform setup, please select a script to run."

printf "%*s\n" $(((${#title}+$cols)/2)) "$title"
printf "%*s\n" $(((${#subtitle1}+$cols)/2)) "$subtitle1"
printf "%*s\n" $(((${#subtitle2}+$cols)/2)) "$subtitle2"
printf "%*s\n\n\n" $(((${#subtitle3}+$cols)/2)) "$subtitle3"
printf "%*s\n\n\n" $(((${#welcome}+$cols)/2)) "$welcome"

# List available scripts
scripts=("$SCRIPTS_DIR"/*.sh)
script_names=()
for script in "${scripts[@]}"; do
    script_names+=("$(basename "$script" .sh)")
done

# Display options
echo "Please select a script to run:"
for i in "${!script_names[@]}"; do
    echo "$((i+1))) ${script_names[$i]}"
done
echo "$(( ${#script_names[@]} + 1 ))) Exit"

# Read user input
read -p "Enter the number of the script to run: " choice

# Validate input and run the selected script
if [[ "$choice" -gt 0 && "$choice" -le "${#script_names[@]}" ]]; then
    selected_script="${scripts[$((choice-1))]}"
    echo "Running $selected_script..."
    bash "$selected_script"
elif [[ "$choice" -eq $(( ${#script_names[@]} + 1 )) ]]; then
    echo "Exiting."
    exit 0
else
    echo "Invalid selection. Exiting."
    exit 1
fi
