#!/bin/bash

while true; do

ip_file="/NoPARASANscripts/ip_list.txt"

ip_regex="/^([0-9]{1,3}\.){3}[0-9]{1,3}$/"

echo "" > "$ip_file"

extract_ips() {
        while read -r line; do
                if [[ $line =~ ([0-9]{1,3}\.){3}[0-9]{1,3} ]]; then
                        ip="${BASH_REMATCH[0]}"
                        echo "$ip" >> "$ip_file"
                        echo "Current Connections: $ip"
                fi
        done
}

echo "Listening for connections..."

last -i | grep "still logged in" | extract_ips

sleep 5
done
