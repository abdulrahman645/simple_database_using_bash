   #!/bin/bash

# List all the databases inside the Database directory
echo "Databases available for creating tables:"
for database in Databases/*; do
  if [ -d "$database" ] && [ -w "$database" ]; then
    echo "$(basename "$database")"
  fi
done

   log_dir="/opt/logs"
   log_file="$log_dir/database_logs.txt"
   excel_file="/opt/logs/database_logs.xlsx"

   # Convert the log file to Excel format
   # Implement the logic to convert the log file to Excel format (e.g., using a tool like csvkit or similar)

   echo "Logs exported to $excel_file successfully."
