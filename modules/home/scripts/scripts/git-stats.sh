#!/usr/bin/env python3
import subprocess
import os
from datetime import datetime, timedelta

def get_stats(directory):
    yesterday = (datetime.now() - timedelta(days=1)).strftime('%Y-%m-%d')
    today = datetime.now().strftime('%Y-%m-%d')
    
    cmd = f'git -C {directory} log --author="$(git config user.name)" --since="{yesterday}" --until="{today}" --pretty=format:"%h - %s"'
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

def main():
    repo_dir = os.path.expanduser("~/repos")
    for root, dirs, _ in os.walk(repo_dir):
        for dir in dirs:
            if os.path.isdir(os.path.join(root, dir, ".git")):
                print(f"\nStats for {dir}:")
                print(get_stats(os.path.join(root, dir)))

if __name__ == "__main__":
    main()