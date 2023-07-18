#!/bin/bash

while true; do

ip_file="/etc/ansible/hosts"

ip_regex="/^127\.0\.0\.1:([0-9]{4})$/"

echo "[workers]" > "$ip_file"

count=1

extract_ips() {
        while read -r line; do
                if [[ $line =~ 127\.0\.0\.1:([0-9]{4}) ]]; then
                        ip="localhost"
                        port="${BASH_REMATCH[1]}"
                        entry="worker$count ansible_host=$ip ansible_port=$port"
                        echo "$entry" >> "$ip_file"
                        ((count ++))
                fi
        done
}

netstat -tlpn | grep "127.0.0.1" | extract_ips

sleep 5
done
