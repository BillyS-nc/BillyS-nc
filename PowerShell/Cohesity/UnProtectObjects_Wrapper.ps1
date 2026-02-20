
 
###########################################################
###           ~ VERSION HISTORY ~                       ###
###     script by RMazur                                ###
###     script was updated by RMazur on 2022-05-17      ###
###########################################################


#### wrapper for script UnProtect_Physical.ps1
####  NOTE: per Brian Seltzer, the Cohesity protectGenericNas.ps1 script is primarily intended to create new jobs not for modifying existing protection groups.
###   If use to modify or update an existing protection group, not all features will work. e.g. some properties like include and exclude lists will not be updated. membership will be updated #####

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

$CohVip="sbch-dp04br.sigi.us.selective.com"
$CohUser="api-test"
$CohDomain="LOCAL"
$LogDir="\PS_Script_Logs\"
$SourceList="\PhysicalSourceList.txt"
$JobList="\ProtectionGroupList.txt"


#################################################################


################################################################################################################################
### creating a log for this PS script ###you can see the time of each entry in the PS script log file.

$CohUnProtectObjectsWrapper="CohUnProtectObjectsWrapperLog"

$TempPSLogfile = "$($CohUnProtectObjectsWrapper)_$(Get-Date -Format "yyyy-MM-dd_HH.mm.ss").txt"

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
Write-Host 'vip =' $CohVip
Write-Host 'user =' $CohUser
Write-Host 'Cohesity domain =' $COHdomain
Write-Host 'Dir =' $Dir
Write-Host 'PowerShell Wrapper Script Log Dir=' $Dir$LogDir
Write-Host 'Object List =' $Dir$SourceList
Write-Host 'Object List =' $Dir$JobList


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

#### run  ./unprotectObjecta.ps1 with options    #### -objectList $Dir$SourceList -objectName 'db331.sigi.us.selective.com'

./unprotectObjects.ps1 -vip $CohVip -username $CohUser -domain $CohDomain -objectList $Dir$SourceList -jobName 'SQL TEST - 14D RET 12AM TLOG'  #-jobList $Dir$JobList



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
Write-Host 'vip =' $CohVip
Write-Host 'user =' $CohUser
Write-Host 'Cohesity domain =' $COHdomain
Write-Host 'Dir =' $Dir
Write-Host 'PowerShell Wrapper Script Log Dir=' $Dir$LogDir

Write-Host 'Object List =' $Dir$SourceList
Write-Host 'Object List =' $Dir$JobList

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


