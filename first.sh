#!/bin/bash

# Check if a file path is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_path>"
    exit 
fi

file_path=$1

# Check if the file exists
if [ ! -e "$file_path" ]; then
    echo "Error: File not found"
    exit 
fi

# Display file information
echo "File information for: $file_path"
echo "------------------------"
echo "Size: $(du -h "$file_path" | cut -f1)"
echo "Type: $(file -b "$file_path")"
echo "Permissions: $(stat -c '%A' "$file_path")"
echo "Owner: $(stat -c '%U' "$file_path")"
echo "Group: $(stat -c '%G' "$file_path")"
echo "Last modified: $(stat -c '%y' "$file_path")"