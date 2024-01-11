#!/bin/bash

email_recipient="your@email.com"
current_date=$(date +"%Y-%m-%d")
log_file="path/to/logs/$current_date.log"  # Adjust the path accordingly

# Extract the numeric value of open sessions
open_sessions=$(tac "$log_file" | grep -m 1 -o "Number of open sessions '[0-9]\+'" | awk -F"'" '{print $2}')

# Get the server hostname
server_hostname=$(hostname)

# Check if the numeric value is greater than 100
if [ "$open_sessions" -gt 100 ]; then
    # Send an email
    email_subject="High Number of Open Sessions Alert on $server_hostname"
    email_body="Server Hostname: $server_hostname\nDate: $current_date\nOpen Sessions: $open_sessions"

    echo -e "Subject: $email_subject\n\n$email_body" | mail -s "$email_subject" "$email_recipient"
    echo "Email sent. Open sessions: $open_sessions"
else
    echo "Number of open sessions is not greater than 100. No email sent."
fi
