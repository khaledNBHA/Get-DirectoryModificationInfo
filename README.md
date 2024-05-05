# Get-DirectoryModificationInfo
This script retrieves Windows security logs to identify the latest modifications of a specified directory, as well as the user who made these modifications. It also allows specifying a date or date range to filter the results.
## Usage
To run the script, use the following command in a PowerShell console:
```shell
.\Get-DirectoryModificationInfo.ps1 -directoryPath "C:\Your\Directory" -numberOfEvents 5 -startDate "2024-05-01" -endDate "2024-05-03"
## Parameters
directoryPath : The path of the directory to monitor. (string, required)
numberOfEvents : The number of recent events to display. (int, optional, default: 10)
startDate : The start date of the search in yyyy-MM-dd format. (string, optional)
endDate : The end date of the search in yyyy-MM-dd format. (string, optional)
## Prerequisites
Ensure you have the necessary permissions to access security logs.
Object access auditing must be enabled in Windows security settings for file and folder modification events to be logged.
## Example
```shell
.\Get-DirectoryModificationInfo.ps1 -directoryPath "C:\Your\Directory" -numberOfEvents 5 -startDate "2024-05-01" -endDate "2024-05-03"
