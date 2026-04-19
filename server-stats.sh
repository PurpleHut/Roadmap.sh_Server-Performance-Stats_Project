#!/bin/bash
echo "Server Performance Stats"
echo "========================"
echo
print_cpu_usage() {
    read -r _ user1 nice1 system1 idle1 iowait1 irq1 softirq1 steal1 guest1 guest_nice1 < <(grep '^cpu ' /proc/stat)
    sleep 1
    read -r _ user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 guest2 guest_nice2 < <(grep '^cpu ' /proc/stat)

    total1=$((user1 + nice1 + system1 + idle1 + iowait1 + irq1 + softirq1 + steal1))
    total2=$((user2 + nice2 + system2 + idle2 + iowait2 + irq2 + softirq2 + steal2))

    idle_total1=$((idle1+iowait1))
    idle_total2=$((idle2+iowait2))

    total_diff=$((total2-total1))

    if [ "$total_diff" -eq 0 ]; then
        echo "Total CPU Usage: 0%"
        return
    fi

    idle_diff=$((idle_total2-idle_total1))

    used_diff=$((total_diff-idle_diff))
    cpu_usage=$((used_diff*100/total_diff))

    echo "Total CPU Usage: ${cpu_usage}%"
    echo
}

print_memory_usage() {
    read -r _ total _ _ _ _ available < <(free -m | grep '^Mem:')

    if [ "$total" -eq 0 ]; then
        echo "Memory Stats:"
        echo "Total: 0 MB"
        echo "Used: 0 MB"
        echo "Free: 0 MB"
        echo "Usage: 0%"
        echo
        return
    fi

    used=$((total - available))
    memory_usage=$((used * 100 / total))

    echo "Memory Stats:"
    echo "Total: ${total} MB"
    echo "Used: ${used} MB"
    echo "Free: ${available} MB"
    echo "Usage: ${memory_usage}%"
    echo
}

print_disk_usage() {
    echo "Disk Usage:"
    printf "%-12s %-12s %-12s %-6s %-10s\n" "Total(KB)" "Used(KB)" "Free(KB)" "Use%" "Mount"

    df -P | awk 'NR>1 && $1 != "tmpfs" && $1 != "udev" && $1 != "devtmpfs" && $1 != "overlay" {
        printf "%-12s %-12s %-12s %-6s %-10s\n", $2, $3, $4, $5, $6
    }'
    echo
}

print_top_cpu_processes() {
    echo "Top 5 processes by CPU usage:"
    ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 6
    echo
}

print_top_memory_processes() {
    echo "Top 5 processes by memory usage:"
    ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -n 6
    echo
}

main() {
    print_cpu_usage
    print_memory_usage
    print_disk_usage
    print_top_cpu_processes
    print_top_memory_processes
}

main