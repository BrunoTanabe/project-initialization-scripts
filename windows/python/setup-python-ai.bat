@echo off
REM PythonAI-ProjectTemplate.bat
REM Author: Bruno Tanabe

REM Introduction:
REM Welcome to the PythonAI-ProjectTemplate.bat script. This utility script is designed to help you
REM quickly set up a standardized folder structure for Python projects focused on Artificial Intelligence.
REM By running this script, you can ensure that your project is organized from the start, making it
REM easier to manage, share, and scale your AI models and code.

REM Purpose:
REM The primary purpose of this script is to automate the creation of directories and basic files
REM needed for a Python AI project. This includes configuring and creating separate virtual environments (/venv) for your data,
REM source code, notebooks, and configuration files, among others. Having a consistent structure
REM not only helps in maintaining the project but also aids in collaboration and deployment processes.

REM Folder Structure Overview:
REM Running this script will create the following directory layout:
REM .
REM ├── config           # Configuration files and environment settings
REM ├── data             # Folder for datasets and data processing scripts
REM ├── env              # Directory for environment settings and configurations
REM ├── docs             # Documentation files for the project
REM ├── models           # Trained models and model definitions
REM ├── notebooks        # Jupyter notebooks for experiments and analysis
REM ├── results          # Store output generated from your experiments and model executions. 
REM ├── scripts          # Additional scripts and automation tools
REM ├── src              # Source code for use in this project
REM ├── tests            # Test cases and testing scripts
REM └── requirements.txt # Python dependencies required for the project

REM How to Use:
REM To utilize this script, simply run it in the root of your project directory. The script will automatically
REM create all the necessary directories and files, allowing you to start your project with a clean and organized structure.

REM Note:
REM Modify the script as needed to fit the specific needs of your project or to integrate additional
REM tools and libraries specific to your workflow. This template serves as a starting point to build
REM a robust environment for developing AI applications with Python.

REM Start the script
echo Starting the setup of the Python AI project structure...
cls

REM Function to display the introduction and instructions
:get_started
(
    echo File: PythonAI-ProjectTemplate.bat
    echo Author: Bruno Tanabe

    echo 1. Introduction:
    echo Welcome to the PythonAI-ProjectTemplate.bat script. This utility script is designed to help you quickly set up a standardized folder structure for Python projects focused on Artificial Intelligence.
    echo By running this script, you can ensure that your project is organized from the start, making it easier to manage, share, and scale your AI models and code.

    echo 2. Purpose:
    echo The primary purpose of this script is to automate the creation of directories and basic files needed for a Python AI project.
    echo This includes configuring and creating separate virtual environments (/venv) for your data, source code, notebooks, and configuration files, among others.
    echo Having a consistent structure not only helps in maintaining the project but also aids in collaboration and deployment processes.

    echo 3. Folder Structure Overview:
    echo Running this script will create the following directory layout:
    echo .
    echo ├── config         # Configuration files and environment settings
    echo ├── data           # Folder for datasets and data processing scripts
    echo ├── venv           # Directory for environment settings and configurations
    echo ├── docs           # Documentation files for the project
    echo ├── models         # Trained models and model definitions
    echo ├── notebooks      # Jupyter notebooks for experiments and analysis
    echo ├── results        # Store output generated from your experiments and model executions.
    echo ├── scripts        # Additional scripts and automation tools
    echo ├── src            # Source code for use in this project
    echo ├── tests          # Test cases and testing scripts
    echo └── requirements.txt # Python dependencies required for the project

    echo 4. How to Use:
    echo To utilize this script, simply run it in the root of your project directory.
    echo The script will automatically create all the necessary directories and files, allowing you to start your project with a clean and organized structure.

    echo 5. Note:
    echo Modify the script as needed to fit the specific needs of your project or to integrate additional tools and libraries specific to your workflow.
    echo This template serves as a starting point to build a robust environment for developing AI applications with Python.

    echo 6. Let's get started!
    echo Press any key to continue...
) >nul
pause >nul

REM Function to check dependencies
:check_dependencies
echo Checking for Git...
where git >nul 2>&1 && (
    echo Git is installed.
) || (
    echo Git is not installed. Please install Git and try again.
    pause
    exit /b 1
)
echo Checking for Python...
where python >nul 2>&1 && (
    echo Python is installed.
) || (
    echo Python is not installed. Please install Python and try again.
    pause
    exit /b 1
)
echo Checking for pip...
python -m pip --version >nul 2>&1 && (
    echo pip is installed.
) || (
    echo pip is not installed. Please install pip and try again.
    pause
    exit /b 1
)
echo Checking for Python venv...
python -m venv --help >nul 2>&1 && (
    echo Python venv is installed.
) || (
    echo Python venv is not installed. Please install Python venv and try again.
    pause
    exit /b 1
)
exit /b 0

REM Function to clone the repository
:clone_repository
set "repo_url=%1"
git clone "%repo_url%" || (
    echo Failed to clone the repository. Check the URL and your connection.
    exit /b 1
)
echo Repository cloned successfully!
exit /b 0

REM Function to create directories and files
:setup_project_structure
mkdir config data docs models notebooks results scripts src tests || (
    echo Failed to create directories. Check your permissions.
    exit /b 1
)
type nul > requirements.txt
type nul > src\main.py
type nul > notebooks\download-packages.ipynb
echo Project directories and initial files created successfully.
exit /b 0

REM Function to create a Python virtual environment
:create_virtual_env
python -m venv venv || (
    echo Failed to create virtual environment.
    exit /b 1
)
echo Virtual environment created.
exit /b 0

REM Function to clone the repository
:clone_commits_pattern
set "repo_url=https://github.com/BrunoTanabe/conventional-commits-pattern.git"
git clone "%repo_url%" docs || (
    echo Failed to clone the repository. Check the URL and your connection.
    exit /b 1
)
echo Repository cloned successfully into docs!

REM Copy the necessary files before removing
copy docs\conventional-commits-pattern\docs\conventional-commit-pattern-ptbr.md docs\ || (
    echo Failed to copy the file conventional-commit-pattern-ptbr.md. Check your permissions.
)
copy docs\conventional-commits-pattern\docs\conventional-commit-pattern.md docs\ || (
    echo Failed to copy the file conventional-commit-pattern.md. Check your permissions.
)
echo Files conventional-commit-pattern-ptbr.md and conventional-commit-pattern.md successfully copied.

REM Remove files that will not be used from the commit pattern repository
rmdir /s /q docs\conventional-commits-pattern || (
    echo Failed to remove files from commits pattern repository. Check your permissions.
)
echo Files removed from the commits pattern repository.
exit /b 0

REM Main script execution
call :get_started
cls
call :check_dependencies
cls

:main_loop
set /p "repo_url=Enter the URL of your project's repository on GitHub (leave empty if none): "

REM Check if the repository URL is empty
if "%repo_url%"=="" (
    call :setup_project_structure
    call :create_virtual_env
    set /p "copy_commits_pattern=Would you like to copy the commit pattern to the docs folder? [y/N] "
    if /i "%copy_commits_pattern%"=="y" (
        call :clone_commits_pattern
    )
    goto :end
) else (
    git ls-remote "%repo_url%" >nul 2>&1 && (
        call :clone_repository "%repo_url%"
        call :setup_project_structure
        call :create_virtual_env
        set /p "copy_commits_pattern=Would you like to copy the commit pattern to the docs folder? [y/N] "
        if /i "%copy_commits_pattern%"=="y" (
            call :clone_commits_pattern
        )
        goto :end
    ) || (
        cls
        echo Invalid repository URL. Please try again.
        goto :main_loop
    )
)

:end
echo Setup complete.
pause
exit /b 0
