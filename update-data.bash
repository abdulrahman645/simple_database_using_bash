#!/bin/bash

# List all databases that the user has write permission for
echo "Databases you have write permission for:"
for database in Databases/*; do
    if [ -d "$database" ] && [ -r "$database" ]; then
        echo "$(basename "$database")"
    fi
done

# Prompt the user to select a database
read -p "Enter the name of the database you want to work with: " selected_database

# Check if the selected database exists and the user has write permission for it
if [ -d "Databases/$selected_database" ] && [ -r "Databases/$selected_database" ]; then
    # List all files with names like $filename + "_structure.txt" in the selected database
    echo "Available tables in $selected_database:"
    for table_structure in Databases/"$selected_database"/*_structure.txt; do
        table_name=$(basename "$table_structure" _structure.txt)
        echo "$table_name"
    done

    # Prompt the user to select a table
    read -p "Enter the name of the table you want to work with: " selected_table

    if [ -f "Databases/$selected_database/$selected_table""_structure.txt" ]; then
        echo "Available columns in $selected_table:"
        awk 'NR>1 {print}' "Databases/$selected_database/$selected_table""_structure.txt"
        read -p "Enter the name of the column you want to update: " selected_column
        if grep -q "^$selected_column$" <(tail -n +2 "Databases/$selected_database/$selected_table""_structure.txt"); then
            read -p "Enter the new value for the column $selected_column: " new_value
            read -p "Enter the ID of the row you want to update: " selected_id
            sudo sed -i "s/\(ID: $selected_id [^ ]* $selected_column: \)[^ ]*/\1$new_value/" "Databases/$selected_database/$selected_table""_data.txt"
            echo "The value of $selected_column has been updated to $new_value for ID: $selected_id."
        else
            echo "Column $selected_column does not exist"
        fi
    else
        echo "Table $selected_table does not exist."
    fi
else
    echo "Either the database doesn't exist or you don't have write permission for it."
fi
