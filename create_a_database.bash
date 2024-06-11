#!/bin/bash

# Check if the database name is provided
if [ -z "$1" ]; then
  echo "Please provide the name of the Database."
  exit 1
fi

# Create the Databases directory if it doesn't exist
if [ ! -d "Databases" ]; then
  mkdir Databases
fi

# Create the database directory
mkdir "Databases/$1"

# Determine if the database is public or private
read -p "Is the database public? (yes/no): " is_public

if [ "$is_public" = "yes" ]; then
  # Set permissions for public database
  chmod -R 775 "Databases/$1"
else
  # Set permissions for private database
  chmod -R 770 "Databases/$1"
fi

# Set the owner of the database
owner=$(whoami)
chown -R $owner "Databases/$1"

# Create a group with the same name as the database
sudo groupadd $1

# Change the group owner of the database directory to the newly created group
sudo chgrp -R $1 "Databases/$1"

# Add the owner and admins to the group
sudo usermod -a -G $1 $owner
while IFS= read -r admin
do
  sudo usermod -a -G $1 $admin
done < "admins.txt"

echo "Database $1 created successfully."
