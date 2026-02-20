
 
###########################################################
###           ~ VERSION HISTORY ~                       ###
###     script by RMazur                                ###
###     script was updated by RMazur on 2022-08-08      ###
###########################################################


#### wrapper for script replicateOldSnapshots.ps1

### setting variable for present working directory / get current directory ###
### this will be on your Selective Insuransce home drive e.g. "G:\PS_Scripts" ###
$PWDir="G:\PS_Scripts\"

### set present working directory for PowerShell session ###
 Set-Location $PWDir

### dot source api helper to pwd / cwd ###
. .\cohesity-api.ps1

### confirmation of present working directory (PWD) for PowerShell. Then setting a variable $DIR in PowerShell and using for this for future operations in the script ###
$Dir= (Get-Item -Path '.\' -Verbose).FullName

################################################################

### setting additional variables for the script

$CohVipSource="sbch-dp01br.sigi.us.selective.com" #"sbch-dp04br.sigi.us.selective.com"
$CohVipDestination= "sbch-dp02az" #"sbch-dp01br" #"sbch-dp02az"
$CohUser="admin_s" #"api-test"
$CohDomain="LOCAL"
$LogDir="\PS_Script_Logs\"
$SourceList="\PhysicalSourceList.txt"
$JobName="SQL_DB_PROD_TLOG_1900_IT20764" #"_DELETED_SQL TEST - PROCEDE DB380T" #"_DELETED_SQL TEST - PROCEDE DB369T" #"TRANS_SQL_PROD11" #"TRANS_SQL_PROD13" #"TRANS_SQL_PROD7" #"TRANS_SQL_PROD9" #"TRANS_SQL_PROD6" #"TRANS_SQL_PROD5" #"TRANS_SQL_PROD" #"TRANS_SQL_PROD8" #"TRANS_SQL_PROD" #"_DELETED_SQL PROD - CL046SQLAP" #"SQL TEST - PROCEDE COPC-DB01T" #"TRANS_SQL_PROD2"  # "_DELETED_SQL TEST - PROCEDE COPC-DB01T" #"SQL TEST - PROCEDE COPC-DB01T"  ##"SQL TEST - PROCEDE COPC-DB01T"
$IfNewerThan="7"
$IfOlderThan="3"
#$IfNewerThan="50"
#$IfOlderThan="365"

#################################################################


################################################################################################################################
### creating a log for this PS script ###you can see the time of each entry in the PS script log file.

$CohReplicateOldSnapshotsWrapper="CohReplicateOldSnapshotsWrapperLog"

$TempPSLogfile = "$($CohReplicateOldSnapshotsWrapper)_$(Get-Date -Format "yyyy-MM-dd_HH.mm.ss").txt"

$PSLogfile = New-Item -Path $Dir -Name $TempPSLogfile -ItemType "file"


function WriteToLogFile
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$LogMessage = "$Stamp $LogString"
Write-Host $LogMessage
}

########### Start PS transcript #########

$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path $PSLogfile


#### PS Script log entry ###
Start-Sleep -Milliseconds 400
WriteToLogFile "Created PS wrapper script log file."

####  wait  ######
Start-Sleep -MilliSeconds 400

#### PS Script log entry ###
WriteToLogFile "PS Wrapper Script log file created, continuing with script...”

#### PS Script log entry ###
Start-Sleep -Milliseconds 100
WriteToLogFile "Running…"
Write-Host "Running..."



Write-Host "                             
"
Write-Host '------------------------------------'
Write-Host 'Script Run Properties'
Write-Host '------------------------------------'
Write-Host 'source vip =' $CohVipSource
Write-Host 'target / destination vip =' $CohVipDestination
Write-Host 'user =' $CohUser
Write-Host 'Cohesity domain =' $COHdomain
Write-Host 'Dir =' $Dir
Write-Host 'PowerShell Wrapper Script Log Dir=' $Dir$LogDir



Write-Host "                             
"

############################################################################################################################################################
### Confirming that the clean-up directory exists. If not, create it. ###

#### PS Script log entry ###
Start-Sleep -Milliseconds 500
WriteToLogFile "Confirming that the clean-up directory exists. If not, create it."

if (Test-Path $Dir$LogDir) {

   WriteToLogFile "Log directory already exists."
 

Start-sleep -s 2

Write-host "wait 2 secs"
}
else
{
  
    #PowerShell Create directory if not exists
    New-Item $Dir$LogDir -ItemType Directory
    WriteToLogFile "Confirming that log directory was created successfully."

}


#### PS Script log entry ###
Start-Sleep -Milliseconds 250
WriteToLogFile "Submitting the request to the Cohesity cluster."

### wait  ###
Start-Sleep -s 1

########################################################################
#######################################################################

#$CohVipSource="sbch-dp04br.sigi.us.selective.com"
#$CohVipDestination="sbch-dp01br.sigi.us.selective.com"
#$CohUser="api-test"
#$CohDomain="LOCAL"
#$LogDir="\PS_Script_Logs\"
#$SourceList="\PhysicalSourceList.txt"
#$JobName="\ProtectionGroupList.txt"
#$IfNewerThan="7"
#$IfOlderThan="45"

#### 
### usage: ./replicateOldSnapshots.ps1 -vip mycluster -username admin [ -domain local ] -replicateTo CohesityVE -olderThan 365 [ -IfExpiringAfter 30 ] [ -keepFor 365 ] [ -archive ]

##### -olderThan 365 [ -IfExpiringAfter 30 ] [ -keepFor 365 ] [ -archive ]
#-IfExpiringAfter 1 #-olderThan $IfOlderThan -IfExpiringAfter 45  ##-IfExpiringAfter 45 #-olderThan $IfOlderThan # -newerThan $IfNewerThan -replicate #-olderThan $IfOlderThan 


./replicateOldSnapshots.ps1 -vip $CohVipSource -username $CohUser -domain $CohDomain -replicateTo $CohVipDestination -jobName $JobName -olderThan $IfOlderThan -newerThan $IfNewerThan -includeLogs -replicate

##########################################################################




Write-Host "                             

passing status" $LASTEXITCODE

Write-Host "                             

"

#### PS Script log entry ###
Start-Sleep -Milliseconds 250
WriteToLogFile "The API request step has completed."

### wait ###
Start-Sleep -Milliseconds 500


### appending BackupNow script status log with boolean / integer exit code and BNYM verbage ###

#### PS Script log entry ###
Start-Sleep -Milliseconds 250
WriteToLogFile "Updating the Wrapper script status log."

WriteToLogFile  "
Backup Register NAS Script Status code returned as: $LASTEXITCODE" 



#### PS Script log entry ###
Start-Sleep -Milliseconds 250
WriteToLogFile "Deleting old log files..."
Write-Host "Deleting old log files..."

### delete logs after 30 days  ###
$CleanupPath = "$Dir$LogDir"
Get-ChildItem –Path $CleanupPath -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-30))} | Remove-Item


Write-Host "Completed removal of old content within" $CleanupPath


### appending wrapper script log with user that last ran the script ###

WriteToLogFile "
This backup script was last run by: $env:USERDOMAIN\$env:username"

#### PS Script log entry ###
Start-Sleep -Milliseconds 250
WriteToLogFile "Script will end in less than 3 seconds..."
Write-Host "Script will end in less than 3 seconds..."

#### PS Script log entry ###
Start-Sleep -Milliseconds 250
WriteToLogFile "End of script activity: Tidying up the various current log files...in progress."
Write-Host "End of script activity: Tidying log files...done."
Write-Host "                             

"
Write-Host '------------------------------------'
Write-Host "Abbreviated Summary"
Write-Host '------------------------------------'
Write-Host '------------------------------------'
Write-Host 'Script Run Properties'
Write-Host '------------------------------------'
Write-Host 'source vip =' $CohVipSource
Write-Host 'target / destination vip =' $CohVipDestination
Write-Host 'Cohesity domain =' $COHdomain
Write-Host 'Dir =' $Dir
Write-Host 'PowerShell Wrapper Script Log Dir=' $Dir$LogDir


Write-Host 'API call Exit Code =' $LASTEXITCODE
Write-Host  $wait
Write-Host "                             
"
############### Stopping PS Transcript    #######

# Been doing some stuff
Stop-Transcript

### backup move various log files to subfolder ###
#Move-Item "*Wrapper*log.log" -Destination $Dir$LogDir
Move-Item $PSLogfile -Destination $Dir$LogDir


