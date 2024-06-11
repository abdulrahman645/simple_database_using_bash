#!/bin/bash

# List all databases that the user has write permission for
echo "Databases you have write permission for:"
for database in Databases/*; do
    if [ -d "$database" ] && [ -w "$database" ]; then
        echo "$(basename "$database")"
    fi
done

# Prompt the user to select a database
read -p "Enter the name of the database you want to work with: " selected_database

# Check if the selected database exists and the user has write permission for it
if [ -d "Databases/$selected_database" ] && [ -w "Databases/$selected_database" ]; then
    # List all files with names like $filename + "_structure" in the selected database
    echo "Available tables in $selected_database:"
    for table_structure in Databases/"$selected_database"/*_structure.txt; do
        table_name=$(basename "$table_structure" _structure.txt)
        echo "$table_name"
    done

    # Prompt the user to select a table
    read -p "Enter the name of the table you want to delete: " selected_table

    # Delete the structure file
    if [ -f "Databases/$selected_database/$selected_table""_structure.txt" ]; then
        rm "Databases/$selected_database/$selected_table""_structure.txt"
        echo "table deleted."
    else 
	echo "table doesn't exist."
    fi

    # Delete the data file if it exists
    if [ -f "Databases/$selected_database/$selected_table""_data.txt" ]; then
        rm "Databases/$selected_database/$selected_table""_data.txt"
    fi
else
    echo "Either the database doesn't exist or you don't have write permission for it."
fi
