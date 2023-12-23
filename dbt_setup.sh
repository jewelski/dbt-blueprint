#!/bin/bash

# create a 'databases' directory if it does not exist
databases_dir="databases"
if [ ! -d "$databases_dir" ]; then
    echo "Creating 'databases' directory..."
    mkdir "$databases_dir"
fi


# define the name of your virtual environment
venv_name="venv"

# check if the virtual environment exists, fail if it does not
if [ ! -d "$venv_name" ]; then
    echo "Error: Virtual environment '$venv_name' does not exist. Please create it first."
    exit 1
fi

echo "Activating the virtual environment: $venv_name"
source "$venv_name/bin/activate"

# specify the path to your requirements.txt file
requirements_file="requirements.txt"

# check if requirements.txt exists, fail if it does not
if [ ! -f "$requirements_file" ]; then
    echo "Error: Requirements file '$requirements_file' not found."
    deactivate
    exit 1
fi

echo "Installing Python packages from $requirements_file..."
pip install -r "$requirements_file"

# fail if pip install fails
if [ $? -ne 0 ]; then
    echo "Error: Failed to install requirements."
    deactivate
    exit 1
fi

# ensure the dbt setup is correctly configured
echo "Running dbt debug to check the dbt project..."
dbt debug

# fail if dbt debug fails
if [ $? -ne 0 ]; then
    echo "Error: dbt debug failed."
    deactivate
    exit 1
fi

# integrate external dbt packages into the dbt project
echo "Running dbt deps"
dbt deps

# fail if dbt deps fails
if [ $? -ne 0 ]; then
    echo "Error: dbt deps failed."
    deactivate
    exit 1
fi

# deactivate the virtual environment and indicate success
echo "Deactivating the virtual environment."
deactivate
echo "Setup completed successfully."
