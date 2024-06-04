#!/bin/bash
# PythonAI-ProjectTemplate.sh
# Author: Bruno Tanabe

# Introduction:
# Welcome to the PythonAI-ProjectTemplate.sh script. This utility script is designed to help you
# quickly set up a standardized folder structure for Python projects focused on Artificial Intelligence.
# By running this script, you can ensure that your project is organized from the start, making it
# easier to manage, share, and scale your AI models and code.

# Purpose:
# The primary purpose of this script is to automate the creation of directories and basic files
# needed for a Python AI project. This includes configuring and creating separate virtual environments (/venv) for your data,
# source code, notebooks, and configuration files, among others. Having a consistent structure
# not only helps in maintaining the project but also aids in collaboration and deployment processes.

# Folder Structure Overview:
# Running this script will create the following directory layout:
# .
# ├── config           # Configuration files and environment settings
# ├── data             # Folder for datasets and data processing scripts
# ├── env              # Directory for environment settings and configurations
# ├── docs             # Documentation files for the project
# ├── models           # Trained models and model definitions
# ├── notebooks        # Jupyter notebooks for experiments and analysis
# ├── results          # Store output generated from your experiments and model executions. 
# ├── scripts          # Additional scripts and automation tools
# ├── src              # Source code for use in this project
# ├── tests            # Test cases and testing scripts
# └── requirements.txt # Python dependencies required for the project

# How to Use:
# To utilize this script, simply make sure it is executable and run it in the root of your
# project directory. You can make the script executable by running:
# chmod +x setup-python-ai.sh
# After that, execute the script by typing:
# ./setup-python-ai.sh
# The script will automatically create all the necessary directories and files, allowing you
# to start your project with a clean and organized structure.

# Note:
# Modify the script as needed to fit the specific needs of your project or to integrate additional
# tools and libraries specific to your workflow. This template serves as a starting point to build
# a robust environment for developing AI applications with Python.

# Start the script
echo "Starting the setup of the Python AI project structure..."
clear

# Function to display the introduction and instructions
get_started()
{
    echo -n -e "\cFile: PythonAI-ProjectTemplate.sh"
    echo -n -e "\cAuthor: Bruno Tanabe"

    echo -e "\n\033[01;34;46m1. Introduction:\033[0m"
    echo -e "\tWelcome to the PythonAI-ProjectTemplate.sh script. This utility script is designed to help you quickly set up a standardized folder structure for Python projects focused on Artificial Intelligence.\n\tBy running this script, you can ensure that your project is organized from the start, making it easier to manage, share, and scale your AI models and code."

    echo -e "\n\033[01;34;46m2. Purpose:\033[0m"
    echo -e "\tThe primary purpose of this script is to automate the creation of directories and basic files needed for a Python AI project.\n\tThis includes configuring and creating separate virtual environments (/venv) for your data, source code, notebooks, and configuration files, among others.\n\tHaving a consistent structure not only helps in maintaining the project but also aids in collaboration and deployment processes."

    echo -e "\n\033[01;34;46m3. Folder Structure Overview:\033[0m"
    echo -e "\tRunning this script will create the following directory layout:\n\t.\n\t├── config\t\t# Configuration files and environment settings\n\t├── data\t\t# Folder for datasets and data processing scripts\n\t├── venv\t\t\t# Directory for environment settings and configurations\n\t├── docs\t\t# Documentation files for the project\n\t├── models\t\t# Trained models and model definitions\n\t├── notebooks\t\t# Jupyter notebooks for experiments and analysis\n\t├── results\t\t# Store output generated from your experiments and model executions.\n\t├── scripts\t\t# Additional scripts and automation tools\n\t├── src\t\t\t# Source code for use in this project\n\t├── tests\t\t# Test cases and testing scripts\n\t└── requirements.txt\t# Python dependencies required for the project"

    echo -e "\n\033[01;34;46m4. How to Use:\033[0m"
    echo -e "\tTo utilize this script, simply make sure it is executable and run it in the root of your project directory.You can make the script executable by running:\n\t\t\033[04;32;40mchmod +x setup-python-ai.sh\033[0m\n\tAfter that, execute the script by typing:\n\t\t\033[04;32;40m./setup-python-ai.sh\033[0m\n\tThe script will automatically create all the necessary directories and files, allowing you to start your project with a clean and organized structure."

    echo -e "\n\033[01;34;46m5. Note:\033[0m"
    echo -e "\tModify the script as needed to fit the specific needs of your project or to integrate additional tools and libraries specific to your workflow.\n\tThis template serves as a starting point to build a robust environment for developing AI applications with Python."

    echo -e "\n\033[01;34;46m6. Let's get started!\033[0m"
    echo -e "\tPress any key to continue..."
    read -n 1 -s -r -p ""
    exit 1
}

# Function to check dependencies
check_dependencies()
{
    # Check for Git, Python3, python3-pip, and Python venv
    echo "Checking for Git..."
    command -v git > /dev/null && {
        echo "Git is installed."
    } || {
        echo "Git is not installed. Would you like to install it? [y/N]"
        read install_git
        if [[ "$install_git" =~ ^[Yy]$ ]]; then
            sudo apt-get install git
        fi
    }
    echo "Checking for Python3..."
    command -v python3 > /dev/null && {
        echo "Python3 is installed."
    } || {
        echo "Python3 is not installed. Would you like to install it? [y/N]"
        read install_python
        if [[ "$install_python" =~ ^[Yy]$ ]]; then
            sudo apt-get install python3
        fi
    }
    echo "Checking for python3-pip..."
    command -v python3-pip > /dev/null && {
        echo "python3-pip is installed."
    } || {
        echo "python3-pip is not installed. Would you like to install it? [y/N]"
        read install_python_pip
        if [[ "$install_python_pip" =~ ^[Yy]$ ]]; then
            sudo apt-get install python3-pip
        fi
    }
    echo "Checking for Python venv..."
    command -v python3 -m venv > /dev/null && {
        echo "Python venv is installed."
    } || {
        echo "Python venv is not installed. Would you like to install it? [y/N]"
        read install_python_venv
        if [[ "$install_python_venv" =~ ^[Yy]$ ]]; then
            sudo apt-get install python3-venv
        fi
    }
    exit 1
}

# Function to clone the repository
clone_repository()
{
    local repo_url=$1
    git clone "$repo_url" || {
        echo "Failed to clone the repository. Check the URL and your connection."
        exit 1
    }
    echo "Repository cloned successfully!"
    exit 1
}

# Function to create directories and files
setup_project_structure()
{
    mkdir -p config data docs models notebooks results scripts src tests || {
        echo "Failed to create directories. Check your permissions."
        exit 1
    }
    touch requirements.txt src/main.py notebooks/download-packages.ipynb || {
        echo "Failed to create requirements.txt, main.py or download-packages.ipynb"
        exit 1
    }
    echo "Project directories and initial files created successfully."
    exit 1
}

# Function to create a Python virtual environment
create_virtual_env()
{
    python3 -m venv venv || {
        echo "Failed to create virtual environment."
        exit 1
    }
    echo "Virtual environment created."
    exit 1
}

# Function to clone the repository
clone_commits_pattern()
{
    local repo_url="https://github.com/BrunoTanabe/conventional-commits-pattern.git"
    git clone "$repo_url" docs || {
        echo "Failed to clone the repository. Check the URL and your connection."
        exit 1
    }
    echo "Repository cloned successfully into docs!" 

    # Copy the necessary files before removing
    cp docs/conventional-commits-pattern/docs/conventional-commit-pattern-ptbr.md docs/ || {
        echo "Failed to copy the file conventional-commit-pattern-ptbr.md. Check your permissions."
    }
    cp docs/conventional-commits-pattern/docs/conventional-commit-pattern.md docs/ || {
        echo "Failed to copy the file conventional-commit-pattern.md. Check your permissions."
    }
    echo "Files conventional-commit-pattern-ptbr.md and conventional-commit-pattern.md successfully copied."

    # Remove files that will not be used from the commit pattern repository
    rm -r docs/conventional-commits-pattern || {
        echo "Failed to remove README.md and LICENSE files from commits pattern repository. Check your permissions."
    }
    echo "README.md and LICENSE files removed from the commits pattern repository."
    exit 1
}

# Main script execution
get_started
clear
check_dependencies
clear

while true; do
    echo -n -e "Enter the URL of your project's repository on GitHub \033[04;31;40m(leave empty if none)(leave empty if you are not cloning the GitHub repository):\033[0m "
    read repo_url

    # Check if the repository URL is empty
    if [[ -z "$repo_url" ]]; then
        setup_project_structure
        create_virtual_env
        echo -n -e "Would you like to copy the commit pattern to the docs folder? [y/N] "
        read copy_commits_pattern
        if [[ "$copy_commits_pattern" =~ ^[Yy]$ ]]; then
            clone_commits_pattern
        fi
        break
    else
        if git ls-remote "$repo_url" > /dev/null 2>&1; then
            clone_repository "$repo_url"
            setup_project_structure
            create_virtual_env
            echo -n -e "Would you like to copy the commit pattern to the docs folder? [y/N] "
            read copy_commits_pattern
            if [[ "$copy_commits_pattern" =~ ^[Yy]$ ]]; then
                clone_commits_pattern
            fi
            break
        else
            clear
            echo "Invalid repository URL. Please try again."
        fi
    fi
done

echo "Setup complete."
exit 1