 
 
### setting variable for present working directory / get current directory ###
### this will be on your Selective Insuransce home drive e.g. "G:\PS_Scripts" ###
$PWDir="G:\PS_Scripts\"

### set present working directory for PowerShell session ###
 Set-Location $PWDir



################ setting variables ###################

$SourceCSV = "G:\PS_Scripts\DBfolders.csv"

$Folders = Import-Csv $SourceCSV -header Foldername


$path =  "\\sbch-dp03br.sigi.us.selective.com\sql_prod3_TEST_ACLs" #"\\sbch-dp03br.sigi.us.selective.com\SQL_PROD3" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_COPS-DB810P_IT20700" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL055SQLAP_IT20793" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL047SQLC_IT20765" #"\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_COPS-DB768T_IT20700"   #"\\sbch-dp01br.sigi.us.selective.com\DESMOND"
$Account = "Everyone" #"SIGITEST\g-cops-db865t$" #"SIGITEST\s-IMSHDB05T_def" #"SIGI\KM_DSM_ETL" #"SIGI\KM_DSM_ETL" #"SIGI\viveks1"

$permissions = 'Read'
$inheritance = 'ContainerInherit, ObjectInherit'


 ################################## clear all ACLs on folders / directories  #################################################
ForEach ($Folder in $Folders) { 
$foldername = $($Folder.Foldername)
$acl = Get-Acl $path\$foldername
$acl.Access | %{$acl.RemoveAccessRule($_)}
}

################### script to set folder permissions on the Cohesity Views useing get-acl set-acl method
#
#ForEach ($Folder in $Folders) { 
#$foldername = $($Folder.Foldername)

#$acl = Get-Acl -Path $path\$foldername
#$ace = New-Object Security.AccessControl.FileSystemAccessRule ($Account, $permissions, $inheritance, 'Inherit', 'Allow')
#$acl.AddAccessRule($ace)
#Set-Acl -AclObject $acl -Path $path\$foldername
#}