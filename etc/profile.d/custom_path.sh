#!/bin/sh
# Define the new PATH order
new_path="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"

# Remove duplicates and clean up empty segments
cleaned_path=$(echo "$PATH" | sed -e 's;/usr/local/sbin;;' -e 's;/usr/local/bin;;' -e 's;/sbin;;' -e 's;/bin;;' -e 's;/usr/sbin;;' -e 's;/usr/bin;;' -e 's;::;:;g' -e 's;^:;;' -e 's;:$;;')

# Combine the new path with the cleaned existing path and remove any leading/trailing colons
export PATH=$(echo "$new_path:$cleaned_path" | sed 's;:\+;:;g' | sed 's;^:;;' | sed 's;:$;;')
