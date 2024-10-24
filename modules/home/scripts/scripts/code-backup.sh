#!/usr/bin/env python3
import os
import shutil
from datetime import datetime

def backup_code():
    source_dir = os.path.expanduser("~/repos")
    backup_dir = os.path.expanduser("~/backups/code")
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    backup_path = os.path.join(backup_dir, f"backup_{timestamp}")
    
    if not os.path.exists(backup_dir):
        os.makedirs(backup_dir)
    
    shutil.make_archive(backup_path, 'zip', source_dir)
    print(f"Backup created at: {backup_path}.zip")

if __name__ == "__main__":
    backup_code()