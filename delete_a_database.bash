#!/bin/bash

# List all the databases inside the Database directory
echo "Databases available for deletion:"
for database in Databases/*; do
  if [ -d "$database" ] && [ -w "$database" ]; then
    echo "$(basename "$database")"
  fi
done

# Prompt the user to choose a database to delete
read -p "Enter the name of the database to delete: " selected_database

# Check if the selected database exists
if [ -d "Databases/$selected_database" ] && [ -w "Databases/$selected_database" ]; then
  # Check if the database is empty
  if [ -z "$(ls -A "Databases/$selected_database")" ]; then
    # Delete the database and its metadata
    rm -r "Databases/$selected_database"
    echo "Database $selected_database and its metadata have been deleted."

    # Delete the group with the same name as the database
    sudo groupdel $selected_database
    echo "Group $selected_database has been deleted."
  else
    echo "Database $selected_database is not empty. Only empty databases can be deleted."
  fi
else
  echo "Database $selected_database does not exist."
fi
