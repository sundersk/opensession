#!/bin/bash

email_recipient="email@abc.com"
current_date=$(date +"%Y-%m-%d")
log_file="/root/$current_date.log"  # Adjust the path accordingly

# Extract the numeric value of open sessions
open_sessions=$(tac "$log_file" | grep -m 1 -o "Number of open sessions '[0-9]\+'" | awk -F"'" '{print $2}')

# Check if the numeric value is greater than 100
if [ "$open_sessions" -gt 100 ]; then
    # Send an email
    echo "Subject: High Number of Open Sessions Alert" | mail -s "High Number of Open Sessions Alert" "$email_recipient"
    echo "Email sent. Open sessions: $open_sessions"
else
    echo "Number of open sessions is not greater than 100. No email sent."
fi
