### note:  this script gets run by the SQL job
#### backup automation credential setup wrapper script
### setting up credentials for another user. e.g. SQL service account running backupNow.ps1 from a SQL job entry in SSMS
### setting variable for present working directory / get current directory ###
### e.g. using my Selective Insuransce home drive e.g. "G:\PS_Scripts" ###
$PWDir="L:\SQLBackups1\SQL_SCRIPTS\COHESITY_SCRIPTS\"
### set present working directory for PowerShell session ###
 Set-Location $PWDir
### dot source api helper to pwd / cwd ###
. ./cohesity-api.ps1
#Storing a Password for a User
#A more secure way to store a password for another user is to use the store/import method. First, the interactive user can store the password:
# . ./cohesity-api.ps1 - if not already dot sourced above
#storePasswordForUser -vip mycluster -username myusername -domain mydomain.net
##storePasswordForUser -vip sbch-dp01br.sigi.us.selective.com -username s-cohesity-batch -domain sigi.us.selective.com

##importStoredPassword -vip mycluster -username myusername -domain mydomain.net -key
importStoredPassword -vip sbch-dp01br.sigi.us.selective.com -username s-cohesity-batch -domain sigi.us.selective.com -key 81394317785952

