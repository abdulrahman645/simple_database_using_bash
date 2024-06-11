#!/bin/bash

# List all the databases inside the Database directory
echo "Databases available for creating tables:"
for database in Databases/*; do
  if [ -d "$database" ] && [ -w "$database" ]; then
    echo "$(basename "$database")"
  fi
done

# Prompt the user to choose a database to create tables in
read -p "Enter the name of the database to create tables in: " selected_database

# Check if the selected database exists
if [ -d "Databases/$selected_database" ] && [ -w "Databases/$selected_database" ]; then
  # Prompt the user to enter table details
  read -p "Enter the name of the table: " table_name
  read -p "Enter the number of columns: " num_columns
  # Create the table file with default ID column
  echo "ID" > "Databases/$selected_database/${table_name}_structure.txt"
  sudo chgrp -R $selected_database "Databases/$selected_database/${table_name}_structure.txt"
  if [ $(stat -c "%a" "Databases/$selected_database") -eq 775 ]; then
    # Perform action if the permissions are 774
    chmod 777 Databases/$selected_database/${table_name}_structure.txt
  else
    # Perform action if the permissions are not 774
    chmod 775 Databases/$selected_database/${table_name}_structure.txt
  fi 
  touch "Databases/$selected_database/${table_name}_data.txt"
  sudo chgrp -R $selected_database "Databases/$selected_database/${table_name}_data.txt"
  if [ $(stat -c "%a" "Databases/$selected_database") -eq 775 ]; then
    # Perform action if the permissions are 774
    chmod 777 Databases/$selected_database/${table_name}_data.txt
  else
    # Perform action if the permissions are not 774
    chmod 775 Databases/$selected_database/${table_name}_data.txt
  fi 

  # Prompt the user to enter the names of columns
  for ((i=1; i<=$num_columns; i++)); do
    read -p "Enter the name of column $i: " column_name
    echo "$column_name" >> "Databases/$selected_database/${table_name}_structure.txt"
  done

  echo "Table $table_name created in database $selected_database."
else
  echo "Database $selected_database does not exist."
fi
