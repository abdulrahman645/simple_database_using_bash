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
	rm -r "Databases/$selected_database/"*
	echo "Database $selected_database has been emptied."
else
  echo "Database $selected_database does not exist."
fi
