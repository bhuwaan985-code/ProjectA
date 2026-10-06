#!/bin/bash

LOG_FILE="log.txt"

# Helper function to append timestamped entries to log.txt
log_entry() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Prompt user for image filename
read -r -p "Hello $(whoami), what image do you want to process? " image_name;

log_entry "Script initiated by user '$(whoami)'. Target image: '$image_name'"

# Part 2: Enclose variable in double quotes to handle filenames with spaces
if [ -f "$image_name" ]
then
    log_entry "File '$image_name' verified."
    
    # Part 1 & Part 3: Process image to B&W and record terminal details to log.txt
    convert "$image_name" -threshold 50% "bw_$image_name" >> "$LOG_FILE" 2>&1

    if [ $? -eq 0 ]
    then
        echo "Image processed successfully";
        log_entry "Success: Created processed image 'bw_$image_name'"
    else
        echo "Image processing failed. See $LOG_FILE for technical details.";
        log_entry "Error: ImageMagick command failed for '$image_name'"
    fi
else
    echo "Verify the filename is correct, and try again";
    log_entry "Error: File '$image_name' not found."
fi
