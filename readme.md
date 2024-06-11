# Simulated Database System

This project simulates the functionality of a database system using Bash scripts. It covers basic database operations such as creating, deleting, and managing databases, as well as performing CRUD operations on tables within those databases. The system distinguishes between public and private databases, with varying access permissions for different types of users.

## Script List

- `backup_restore_database.bash`: Backup and restore database functionalities.
- `create_a_database.bash`: Create a new database.
- `create_tables.bash`: Create tables within a database.
- `delete_a_database.bash`: Delete an existing database.
- `delete_data.bash`: Delete data from a table.
- `delete_tables.bash`: Delete tables from a database.
- `empty_a_database.bash`: Empty a database.
- `insert_data.bash`: Insert data into a table.
- `logs_of_databases.bash`: Log database operations.
- `main.bash`: Main entry point for the application.
- `readme.md`: This file.
- `retrieve_data.bash`: Retrieve data from a table.
- `update-data.bash`: Update data in a table.

## Getting Started

### Prerequisites

- Basic understanding of Bash scripting and Linux commands.
- Familiarity with terminal navigation and command execution.

### Setup Instructions

1. Ensure your environment meets the prerequisites.
2. Clone the repository to your local machine.
3. Navigate to the project directory.
4. Make sure all scripts have executable permissions (`chmod +x script_name.bash`).
5. Execute `./main.bash` to start the application.

## Usage Guide

Follow these steps to interact with the simulated database system:

1. **Create a Database**: Use `./create_a_database.bash` to initiate a new database, specifying whether it's public or private.
2. **Delete a Database**: Utilize `./delete_a_database.bash` to remove a database, selecting from the available options.
3. **Empty a Database**: Employ `./empty_a_database.bash` to clear all data from a chosen database.
4. **Manage Tables**: Use `./create_tables.bash` to create tables within a database.
5. **Perform CRUD Operations**:
   - Insert data: `./insert_data.bash`
   - Retrieve data: `./retrieve_data.bash`
   - Update data: `./update-data.bash`
   - Delete data: `./delete_data.bash`
   - Delete tables: `./delete_tables.bash`

## Access Control

- **Public Databases**: Accessible to all users.
- **Private Databases**: Access restricted to the owner, admin(s), and users added to the database's group.
