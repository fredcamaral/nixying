#!/usr/bin/env python3
import os
import subprocess
import concurrent.futures
from typing import List

repo_directory = os.path.expanduser("~/repos")
BATCH_SIZE = 50

def is_git_directory(directory: str) -> bool:
    return os.path.isdir(os.path.join(directory, ".git"))

def get_git_main_branch(directory: str) -> str:
    try:
        result = subprocess.run(
            ["git", "-C", directory, "rev-parse", "--abbrev-ref", "HEAD"],
            check=True, capture_output=True, text=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Failed to determine the main branch for {directory}. Error: {str(e)}")
        return None

def git_pull(directory: str) -> None:
    main_branch = get_git_main_branch(directory)
    
    if main_branch is None:
        print(f"Skipping pull operation for {directory}.")
        return

    try:
        subprocess.run(
            ["git", "-C", directory, "pull", "origin", main_branch],
            check=True, capture_output=True, text=True
        )
        print(f"Successfully updated {directory} from '{main_branch}' branch.")
    except subprocess.CalledProcessError as e:
        print(f"Failed to update {directory} from '{main_branch}' branch. Error: {str(e)}")

def process_repositories(repositories: List[str]) -> None:
    with concurrent.futures.ThreadPoolExecutor(max_workers=BATCH_SIZE) as executor:
        executor.map(git_pull, repositories)

def main():
    if not os.path.exists(repo_directory):
        print(f"The directory {repo_directory} does not exist.")
        return

    repositories = []
    for root, dirs, _ in os.walk(repo_directory):
        for dir in dirs:
            full_dir_path = os.path.join(root, dir)
            
            if ".terraform" in full_dir_path.split("/") or ".terragrunt-cache" in full_dir_path.split("/"):
                continue

            if is_git_directory(full_dir_path):
                repositories.append(full_dir_path)

    # Process repositories in batches of BATCH_SIZE
    for i in range(0, len(repositories), BATCH_SIZE):
        batch = repositories[i:i + BATCH_SIZE]
        process_repositories(batch)

if __name__ == "__main__":
    main()
