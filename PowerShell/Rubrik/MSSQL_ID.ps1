Connect-Rubrik -Server sbrb-dp01br -Id "client|3a2a1f52-4c89-42ee-9699-7fa8d4d0ccae" -Secret "pOMDppcCqUZON_hJA_l5jLIyiNR0cM8-878EoZS5GfX6tOWuOeyBQKBjCkmmnnAL"
#get-rubrikdatabase | Select * | Select Name, "Instance Name", ID > L:\Billy\PowerShell_scripts\Rubrik\log\raw_output.csv
get-rubrikdatabase | Select * | Select-Object name, instanceName, ID, rootProperties > L:\Billy\PowerShell_scripts\Rubrik\log\raw_output.csv

$MssqlDatabaseIds = Import-Csv L:\Billy\PowerShell_scripts\Rubrik\log\raw_output.csv
ForEach ($MssqlDatabaseId in $MssqlDatabaseIds){
$MssqlDatabaseIds
}


############Temp code##########

ForEach ($MssqlDatabaseId in $MssqlDatabaseIds){
    $Properties = $MssqlDatabaseId | Select * | Select-Object rootProperties
    $hostname = $MssqlDatabaseId.rootProperties #$database.HostName
    Write-Host "The host name for database ID $databaseId is: $rootName" #$hostname"
} else {
    Write-Warning "Could not find a database with ID: $databaseId"
}

###########End Temp code#######






# Get the hostname
ForEach ($MssqlDatabaseID in $MssqlDatabaseIDS){
$hostname = Get-Rubrikdatabase -Id $MssqlDatabaseIds

if ($null -ne $hostname) {
    Write-Host "The hostname for database ID $MssqlDatabaseIds is: $hostname"
}
}



Get-Rubrikdatabase -Id MssqlDatabase:::ffdc05ce-a175-458c-9e2f-700b8c0c6e9b

$databaseid = "MssqlDatabase:::ffdc05ce-a175-458c-9e2f-700b8c0c6e9b"
$database = Get-RubrikDatabase -ID $databaseid | Select-Object rootProperties
if ($database) {
    $hostname = $database.rootProperties #$database.HostName
    Write-Host "The host name for database ID $databaseId is: $rootName" #$hostname"
} else {
    Write-Warning "Could not find a database with ID: $databaseId"
}
Write-Host " $databaseId"
Get-Rubrikhost -Id MssqlDatabase:::ffdc05ce-a175-458c-9e2f-700b8c0c6e9b










#}

function Get-RubrikMssqlHostName {
    param (
        [Parameter(Mandatory = $true)]
        [string]$MssqlDatabaseId
    )










    # 1. Get the SQL database object using its ID.
    # The -DetailedObject switch is needed to retrieve the parent object information.
    try {
        #$mssqlDatabase = Get-RubrikDatabase -id $MssqlDatabaseId -DetailedObject
         #$mssqlDatabase = Get-RubrikDatabase| Select * | Select ID
         #$MssqlDatabaseIds = Import-Csv L:\Billy\PowerShell_scripts\Rubrik\log\database_ID.csv
         $MssqlDatabaseIds = Import-Csv L:\Billy\PowerShell_scripts\Rubrik\log\raw_output.csv
         #$mssqlDatabase = Get-RubrikDatabase -id $MssqlDatabaseId -DetailedObject
         $mssqlDatabase = $MssqlDatabaseIds | Select id
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