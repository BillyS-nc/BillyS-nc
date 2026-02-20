#Connect-Rubrik -Server 10.59.1.190 -Id "client|3a2a1f52-4c89-42ee-9699-7fa8d4d0ccae" -Secret "pOMDppcCqUZON_hJA_l5jLIyiNR0cM8-878EoZS5GfX6tOWuOeyBQKBjCkmmnnAL"
Connect-Rubrik -Server sbrb-dp01br -Id "client|3a2a1f52-4c89-42ee-9699-7fa8d4d0ccae" -Secret "pOMDppcCqUZON_hJA_l5jLIyiNR0cM8-878EoZS5GfX6tOWuOeyBQKBjCkmmnnAL"

#Get-RubrikDatabase -Relic:$false -name "master" -DetailedObject -Verbose > L:\Billy\PowerShell_scripts\Rubrik\log\database_output.txt

function Get-RubrikMssqlHostName {
    param (
        [Parameter(Mandatory = $true)]
        [string]$MssqlDatabaseId
    )

    # 1. Get the SQL database object using its ID.
    # The -DetailedObject switch is needed to retrieve the parent object information.
    try {
        $mssqlDatabase = Get-RubrikDatabase -id $MssqlDatabaseId -DetailedObject
    }
    catch {
        Write-Error "Could not retrieve the database with ID: $MssqlDatabaseId. Please verify the ID."
        return $null
    }

    if ($null -eq $mssqlDatabase) {
        Write-Warning "No database found for the specified ID: $MssqlDatabaseId"
        return $null
    }

    # 2. Get the parent SQL instance ID from the database object.
    $mssqlInstanceId = $mssqlDatabase.sqlInstanceId

    # 3. Use the instance ID to get the full SQL instance object.
    try {
        $mssqlInstance = Get-RubrikSQLInstance -id $mssqlInstanceId
    }
    catch {
        Write-Error "Could not retrieve the SQL instance with ID: $mssqlInstanceId."
        return $null
    }

    if ($null -eq $mssqlInstance) {
        Write-Warning "No SQL instance found for the specified ID: $mssqlInstanceId"
        return $null
    }

    # 4. Extract and return the hostname from the instance object.
    return $mssqlInstance.hostname
}

# --- Example Usage ---

# Replace with your specific Rubrik MSSQL Database ID
$dbId = "MssqlDatabase:::00516e45-ff11-4b98-9858-31354546388c" 

# Get the hostname
$hostname = Get-RubrikMssqlHostName -MssqlDatabaseId $dbId

if ($null -ne $hostname) {
    Write-Host "The hostname for database ID $dbId is: $hostname"
}
