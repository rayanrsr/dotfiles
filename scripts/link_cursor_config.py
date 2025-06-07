#!/usr/bin/env python3
"""
Script to create symbolic links from ~/.config/cursor/* to ~/Library/Application Support/Cursor/*
This allows your chezmoi-managed config to override the default Cursor configuration.
"""

import os
import shutil
from pathlib import Path
from datetime import datetime
import sys


def backup_existing_files(target_dir: Path, backup_dir: Path) -> None:
    """Backup existing files that would be overridden by symlinks."""
    if not target_dir.exists():
        print(f"Target directory {target_dir} does not exist, nothing to backup")
        return

    backup_dir.mkdir(parents=True, exist_ok=True)
    print(f"Creating backup directory: {backup_dir}")

    for item in target_dir.rglob("*"):
        if item.is_file() or (item.is_dir() and not any(item.iterdir())):
            relative_path = item.relative_to(target_dir)
            backup_path = backup_dir / relative_path
            backup_path.parent.mkdir(parents=True, exist_ok=True)

            if item.is_file():
                shutil.copy2(item, backup_path)
                print(f"Backed up file: {relative_path}")
            elif item.is_dir():
                backup_path.mkdir(exist_ok=True)
                print(f"Backed up empty directory: {relative_path}")


def remove_conflicting_items(source_dir: Path, target_dir: Path) -> None:
    """Remove items in target that would conflict with symlinks from source."""
    if not source_dir.exists():
        print(f"Source directory {source_dir} does not exist")
        return

    if not target_dir.exists():
        print(f"Target directory {target_dir} does not exist")
        return

    for source_item in source_dir.rglob("*"):
        if source_item.is_file() or source_item.is_dir():
            relative_path = source_item.relative_to(source_dir)
            target_item = target_dir / relative_path

            if target_item.exists():
                if target_item.is_dir():
                    shutil.rmtree(target_item)
                    print(f"Removed directory: {relative_path}")
                else:
                    target_item.unlink()
                    print(f"Removed file: {relative_path}")


def create_symlinks(source_dir: Path, target_dir: Path) -> None:
    """Create symbolic links from source to target, maintaining directory structure."""
    if not source_dir.exists():
        print(f"Source directory {source_dir} does not exist")
        return

    target_dir.mkdir(parents=True, exist_ok=True)

    for source_item in source_dir.iterdir():
        target_item = target_dir / source_item.name

        # Remove existing target if it exists
        if target_item.exists() or target_item.is_symlink():
            if target_item.is_dir() and not target_item.is_symlink():
                shutil.rmtree(target_item)
            else:
                target_item.unlink()

        # Create symlink
        os.symlink(source_item, target_item)
        print(f"Created symlink: {target_item} -> {source_item}")


def main():
    """Main function to orchestrate the symlinking process."""
    home = Path.home()
    source_dir = home / ".config" / "cursor"
    target_dir = home / "Library" / "Application Support" / "Cursor"

    # Create backup directory with timestamp
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir = home / ".cursor_config_backup" / f"backup_{timestamp}"

    print("=== Cursor Configuration Symlink Setup ===")
    print(f"Source: {source_dir}")
    print(f"Target: {target_dir}")
    print(f"Backup: {backup_dir}")
    print()

    if not source_dir.exists():
        print(f"Error: Source directory {source_dir} does not exist!")
        sys.exit(1)

    # Ask for confirmation
    print("This will:")
    print("1. Backup existing Cursor config files")
    print("2. Remove conflicting files from Application Support")
    print("3. Create symbolic links from ~/.config/cursor to Application Support")
    print()

    response = input("Continue? (y/N): ").lower().strip()
    if response != "y" and response != "yes":
        print("Aborted.")
        sys.exit(0)

    try:
        # Step 1: Backup existing files that would be overridden
        print("\n=== Step 1: Backing up existing files ===")
        items_to_backup = []
        for source_item in source_dir.rglob("*"):
            if source_item.is_file() or source_item.is_dir():
                relative_path = source_item.relative_to(source_dir)
                target_item = target_dir / relative_path
                if target_item.exists():
                    items_to_backup.append(target_item)

        if items_to_backup:
            backup_dir.mkdir(parents=True, exist_ok=True)
            for item in items_to_backup:
                relative_path = item.relative_to(target_dir)
                backup_path = backup_dir / relative_path
                backup_path.parent.mkdir(parents=True, exist_ok=True)

                if item.is_file():
                    shutil.copy2(item, backup_path)
                    print(f"Backed up file: {relative_path}")
                elif item.is_dir() and not item.is_symlink():
                    shutil.copytree(item, backup_path, dirs_exist_ok=True)
                    print(f"Backed up directory: {relative_path}")
        else:
            print("No files need backing up.")

        # Step 2: Remove conflicting items
        print("\n=== Step 2: Removing conflicting files ===")
        remove_conflicting_items(source_dir, target_dir)

        # Step 3: Create symlinks
        print("\n=== Step 3: Creating symbolic links ===")
        create_symlinks(source_dir, target_dir)

        print(f"\n✅ Successfully created symbolic links!")
        print(
            f"Your ~/.config/cursor configuration now overrides the Application Support settings."
        )
        if backup_dir.exists() and any(backup_dir.iterdir()):
            print(f"📁 Backup of original files saved to: {backup_dir}")

    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
