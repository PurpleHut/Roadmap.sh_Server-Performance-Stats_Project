# Server Performance Stats

> A simple Bash script for monitoring Linux server performance.

## Description

This project is a simple Bash script for monitoring basic Linux server performance statistics.

## Features

The script provides the following information:

* Total CPU usage
* Total memory usage (used, free, percentage)
* Total disk usage
* Top 5 processes by CPU usage
* Top 5 processes by memory usage

## How to Run

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/server-stats.git
   cd server-stats
   ```

2. Make the script executable:

   ```bash
   chmod +x server-stats.sh
   ```

3. Run the script:

   ```bash
   ./server-stats.sh
   ```

## Example Output

```
Total CPU Usage: 23%

Memory Stats:
Total: 8000 MB
Used: 3200 MB
Free: 4800 MB
Usage: 40%

Disk Usage:
Total        Used         Free         Use%  Mount
11758760     5070496      6069156      46%   /

Top 5 processes by CPU usage:
PID   USER   %CPU   %MEM   COMMAND
...

Top 5 processes by memory usage:
...
```

## Requirements

* Linux system (tested on Ubuntu Server 24.04)
* Bash

## What I Learned

* Bash scripting fundamentals
* Working with `/proc/stat`
* Parsing command output (`free`, `df`, `ps`)
* Using `awk` for text processing
* Writing structured and readable scripts
