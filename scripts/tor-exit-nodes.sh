#!/bin/bash

existing_list='../blacklists/tor_exit_nodes.txt'
tmp=$(mktemp)
dowmload="https://check.torproject.org/exit-addresses"

# add new IPs to the file
curl -s $dowmload | awk '/ExitAddress/ {print $2}' > $tmp

# Merge list
if [ -f $existing_list ]; then
    cat $existing_list >> $tmp
else
    touch "$existing_list"
fi


# Order and remove duplicates
cat $tmp | sort -n | uniq > $existing_list

cat $existing_list
# if you want to host it your self add cat "$existing_list"