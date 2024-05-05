# Get-DirectoryModificationInfo.ps1

This script retrieves Windows security logs to identify the latest modifications in a specified directory and the user who made these modifications. It also allows specifying a date or date range to filter the results.

## Description

The script leverages Windows security logs to monitor a specific directory for any file or folder modifications (event ID 4663). You can specify the directory path, the number of recent events to display, and an optional date range to filter the results.

## Usage

Run the script with the desired parameters to obtain information about the latest modifications of a given directory.

## Parameters
'directoryPath (string): The path of the directory to monitor.
'numberOfEvents (int): The number of recent events to display.
'startDate (string, optional): The start date of the search in yyyy-MM-dd format.
'endDate (string, optional): The end date of the search in yyyy-MM-dd format.

## Requirements
The script requires administrative privileges to access security logs.
Object access auditing must be enabled in Windows security settings for file and folder modification events to be logged.
Output
The script outputs the user who made the modification and the time of modification.

## Troubleshooting
Ensure you have the necessary permissions to access security logs.
Verify that the specified directory path exists and is correctly formatted.
If you encounter errors, make sure that object access auditing is enabled in your Windows security settings.
## License
This project is licensed under the MIT License.

### Example
The example retrieves the 5 most recent events in "C:\Your\Directory" between May 1, 2024, and May 3, 2024 :
```powershell
.\Get-DirectoryModificationInfo.ps1 -directoryPath "C:\Your\Directory" -numberOfEvents 5 -startDate "2024-05-01" -endDate "2024-05-03"

