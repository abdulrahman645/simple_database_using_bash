#!/bin/bash

PS3="Select an option: "
options=(
    "Create a Database"
    "Delete a Database"
    "Empty a Database"
    "Create tables"
    "Delete tables"
    "Insert data"
    "Retrieve data"
    "Update data"
    "Delete data"
    "Backup & Restore Database"
    "View Database Logs"
    "exit"
)

select opt in "${options[@]}"
do
    case $opt in
        "Create a Database")
            ./createdatabase.bash 
            ;;
        "Delete a Database")
            ./deletedatabase.bash 
            ;;
        "Empty a Database")
            ./emptydatabase.bash
            ;;
        "Create tables")
            ./createtable.bash
            ;;
        "Delete tables")
            .deletetable.bash 
            ;;
        "Insert data")
           ./insertdata.bash
            ;; 
        "Retrieve data")
            ./retrivedata.bash
            ;;       
        "Update data")
            ./updatedata.bash
            ;;
        
        "Delete data")
            ./deletedata.bash
            ;;
        
        "Backup & Restore Database")
            ./backup_restore_database.bash
            ;;
        "View Database Logs")
            ./logs_of_databases.bash
            ;;
        "exit")
            break
            ;;
        *) echo "Invalid option";;
    esac
done
