<#
    Script Name: Get-DirectoryModificationInfo.ps1
    Description: This script retrieves Windows security logs to identify the latest modifications of a specified directory, as well as the user who made these modifications. It also allows specifying a date or date range to filter the results.

    Author: Khaled Nedjari Benhadj Ali
    Role: RSSI (Information Systems Security Officer) at Groupe GICA

    Parameters:
        - $directoryPath : (string) The path of the directory to monitor.
        - $numberOfEvents : (int) The number of recent events to display.
        - $startDate : (string) The start date of the search in the format yyyy-MM-dd (optional).
        - $endDate : (string) The end date of the search in the format yyyy-MM-dd (optional).

    Usage:
        Run the script with the desired parameters to obtain information about the latest modifications of a given directory.

        Example:
            .\Get-DirectoryModificationInfo.ps1 -directoryPath "C:\Your\Directory" -numberOfEvents 5 -startDate "2024-05-01" -endDate "2024-05-03"

    Notes:
        - Make sure you have the necessary permissions to access security logs.
        - Object access auditing must be enabled in Windows security settings for file and folder modification events to be logged.

#>

# Script parameters
param (
    # Path of the directory to monitor
    [string]$directoryPath = "C:\Your\Directory",

    # Number of recent events to display
    [int]$numberOfEvents = 10,

    # Start date of the search in the format yyyy-MM-dd
    [string]$startDate = "",

    # End date of the search in the format yyyy-MM-dd
    [string]$endDate = ""
)

# Convert date strings to DateTime objects
if ($startDate) {
    $startDate = [datetime]$startDate
}
if ($endDate) {
    $endDate = [datetime]$endDate
}

# Retrieve security logs (Security) and filter by event ID 4663 (file or folder modification)
$logs = Get-EventLog -LogName Security | Where-Object {
    $_.EventID -eq 4663 -and $_.ReplacementStrings -contains $directoryPath
} | Where-Object {
    # Filter by date if start and end dates are specified
    ($startDate -eq $null -or $_.TimeGenerated -ge $startDate) -and
    ($endDate -eq $null -or $_.TimeGenerated -le $endDate)
} | Select-Object -Last $numberOfEvents

# Iterate through logs and display information on the latest modification
foreach ($log in $logs) {
    # Check if ReplacementStrings exists and contains elements
    if ($log.ReplacementStrings -ne $null -and $log.ReplacementStrings.Count > 0) {
        try {
            # Obtain the event time
            $time = $log.TimeGenerated

            # Extract information about the user who made the modification
            $username = $log.ReplacementStrings[6]

            Write-Host "Modification made by: $username | Time of modification: $time"
        } catch {
            Write-Host "Error processing event: $_"
        }
    } else {
        Write-Host "Unable to process event, ReplacementStrings is null or empty."
    }
}
