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

    # Check if the selected table file exists
    if [ -f "Databases/$selected_database/$selected_table""_structure.txt" ]; then
        # Read the structure file to get the names of the values, skipping the first line
        structure_file="Databases/$selected_database/$selected_table""_structure.txt"
        values=()
        first_line=true
        while IFS= read -r line; do
            if [ "$first_line" = false ]; then
                values+=("$line")
            else
                first_line=false
            fi
        done < "$structure_file"

        # Prompt the user to enter the values for the table
	user_input=""
	for value in "${values[@]}"; do
    		read -p "Enter the $value: " input
    		user_input="$user_input $value: $input"
	done

	# Check if the data file exists, if not, create it
	data_file="Databases/$selected_database/$selected_table""_data.txt"
	if [ ! -f "$data_file" ]; then
    	touch "$data_file"
        sudo chgrp -R $selected_database "Databases/$selected_database/${table_name}_data.txt"
        if [ $(stat -c "%a" "Databases/$selected_database") -eq 775 ]; then
            # Perform action if the permissions are 774
            chmod 777 Databases/$selected_database/${table_name}_data.txt
        else
            # Perform action if the permissions are not 774
            chmod 775 Databases/$selected_database/${table_name}_data.txt
        fi 
    	echo "ID: 1 $user_input" >> "$data_file"
	else
    	# Read the data file to get the last ID and generate a new unique one
    	last_id=$(grep "^ID:" "$data_file" | tail -1 | awk '{print $2}')
    	new_id=$((last_id + 1))
    	echo "ID: $new_id $user_input" >> "$data_file"
	fi
	echo "Data added successfully."
    else
        echo "Table $selected_table does not exist."
    fi
else
    echo "Either the database doesn't exist or you don't have write permission for it."
fi
