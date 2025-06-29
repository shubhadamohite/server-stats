#!/bin/bash

echo "===== Server Performance Stats ====="

# CPU Usage
echo -e "\n[CPU Usage]:"
# runs top (real-time system monitor) in logging mode capturing CPU usage looping once 
top -l 1 | grep "CPU usage"

# Memory Usage
echo -e "\n[Memory Usage]:"
# print memory page stats and filter for line showing free memory, etc 
vm_stat | awk '/Pages free/ || /Pages active/ || /Pages inactive/ || /Pages speculative/ || /Pages wired down/ {print}'
free_mem=$(vm_stat | awk '/Pages free/ {free=$3} END {print free * 4096 / 1024 / 1024 " MB"}')
echo "Free memory (approx): $free_mem"

# Disk Usage
echo -e "\n[Disk Usage]:"
# Disk  Free tells us about the disk space used and available on mounted filesystems only from the root partition '/'
df -h /

# Top 5 processes by CPU
echo -e "\n[Top 5 CPU Processes]:"
# process status shows currently running processes on your system 
{ echo "PID CMD %MEM"; ps -Ao pid,args,%mem | sort -k 3 -nr | head -n 5; } | column -t

# Top 5 processes by Memory
echo -e "\n[Top 5 Memory Processes]:"
{ echo "PID CMD %CPU"; ps -Ao pid,args,%cpu | sort -k 3 -nr | head -n 5; } | column -t

# Uptime
echo -e "\n[Uptime]:"
uptime

echo -e "\n===== Done ====="

