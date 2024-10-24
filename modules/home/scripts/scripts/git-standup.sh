#!/usr/bin/env python3
import subprocess
import os
from datetime import datetime, timedelta

def get_standup_report(directory):
    yesterday = (datetime.now() - timedelta(days=1)).strftime('%Y-%m-%d')
    cmd = f"""
    git -C {directory} log --since="{yesterday}" --author="$(git config user.name)" --pretty=format:"%s%n- %b"
    """
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout.strip()

def main():
    repo_dir = os.path.expanduser("~/repos")
    print("=== Your Git Activity ===")
    
    for root, dirs, _ in os.walk(repo_dir):
        for dir in dirs:
            full_path = os.path.join(root, dir)
            if os.path.isdir(os.path.join(full_path, ".git")):
                report = get_standup_report(full_path)
                if report:
                    print(f"\n{dir}:")
                    print(report)

if __name__ == "__main__":
    main()