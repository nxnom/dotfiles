#!/bin/bash

# Prompt the user to input the Python version
read -p "Enter the Python version: " python_version

# Create the .envrc file and set the layout for Python
echo "layout python" > .envrc

# Write the user-provided Python version to the .tool-versions file
echo "python $python_version" > .tool-versions

# Allow direnv to use the environment settings
direnv allow

# Output success message
echo "Python version $python_version set successfully in .tool-versions and .envrc updated."
