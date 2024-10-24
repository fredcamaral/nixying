#!/usr/bin/env python3
"""
This script automates the process of updating Git repositories located in a specified directory.
It walks through the directory structure, identifies Git repositories, determines their main branch,
and performs a 'git pull' operation to update each repository.

Features:
- Git Repository Identification: Checks directories to determine if they are Git repositories.
- Main Branch Detection: Dynamically identifies the main branch for each repository.
- Automated Git Pull: Executes a 'git pull' command for the main branch of each repository.
- Directory Exclusion: Excludes directories related to Terraform and Terragrunt to avoid unnecessary processing.

Dependencies:
- Git: For managing and updating the repositories.
- Python 3 and standard libraries: os, subprocess.

Usage:
The script is executed as a standalone Python script. It automatically searches for Git repositories 
in a predefined directory (default is '~/Documents/repositories') and updates them.
"""

__author__ = "Alexander Nabokikh"
__license__ = "GPL-2.0 license"


import os
import subprocess

repo_directory = os.path.expanduser("~/repos")


def is_git_directory(directory):
    """
    Checks if a directory is a Git repository by looking for a .git subdirectory.
    """
    return os.path.isdir(os.path.join(directory, ".git"))


def get_git_main_branch(directory):
    """
    Determines the name of the main branch for the Git repository located at 'directory'.
    """
    os.chdir(directory)
    try:
        result = subprocess.run(
            ["git", "rev-parse", "--abbrev-ref", "HEAD"], check=True, capture_output=True, text=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Failed to determine the main branch for {directory}. Error: {str(e)}")
        return None


def git_pull(directory):
    """
    Performs a Git pull operation in the specified directory.
    """
    os.chdir(directory)  # Navigate to directory
    main_branch = get_git_main_branch(directory)

    if main_branch is None:
        print(f"Skipping pull operation for {directory}.")
        return

    try:
        # Run git pull command for the detected main branch
        subprocess.run(["git", "pull", "origin", main_branch], check=True, capture_output=True, text=True)
        print(f"Successfully updated {directory} from '{main_branch}' branch.")
    except subprocess.CalledProcessError as e:
        print(f"Failed to update {directory} from '{main_branch}' branch. Error: {str(e)}")


def main():
    if os.path.exists(repo_directory):
        for root, dirs, _ in os.walk(repo_directory):
            for dir in dirs:
                full_dir_path = os.path.join(root, dir)

                # Skip if the directory is under a .terraform directory
                if ".terraform" in full_dir_path.split("/") or ".terragrunt-cache" in full_dir_path.split("/"):
                    continue

                if is_git_directory(full_dir_path):
                    git_pull(full_dir_path)
    else:
        print(f"The directory {repo_directory} does not exist.")


if __name__ == "__main__":
    main()