#!/usr/bin/env python3
import psutil
import time

def check_system():
    cpu_percent = psutil.cpu_percent(interval=1)
    memory = psutil.virtual_memory()
    disk = psutil.disk_usage('/')
    
    print(f"\nSystem Health Report:")
    print(f"CPU Usage: {cpu_percent}%")
    print(f"Memory Usage: {memory.percent}%")
    print(f"Disk Usage: {disk.percent}%")
    
    if cpu_percent > 80 or memory.percent > 80 or disk.percent > 80:
        return "WARNING: High resource usage detected!"
    return None

def main():
    while True:
        warning = check_system()
        if warning:
            subprocess.run(['notify-send', 'System Alert', warning])
        time.sleep(300)  # Check every 5 minutes

if __name__ == "__main__":
    main()