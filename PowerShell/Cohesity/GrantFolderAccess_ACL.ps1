
 
 
### setting variable for present working directory / get current directory ###
### this will be on your Selective Insuransce home drive e.g. "G:\PS_Scripts" ###
$PWDir="D:\Scripts\PS_Scripts\"

### set present working directory for PowerShell session ###
 Set-Location $PWDir


 ################### script to set folder permissions on the Cohesity Views useing get-acl set-acl method


$SourceCSV = "D:\Scripts\PS_Scripts\DirList.csv" #"G:\PS_Scripts\DBfolders.csv"

$Folders = Import-Csv $SourceCSV -header Foldername


$path = "\\sbch-dp01br.sigi.us.selective.com\Cohesity_Archive" #"\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_DB371T_IT20726" #"\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_BLAP-DB739T_IT20726" #"\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_BLAP-DB750T_IT20726" #"\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_BLAP-DB739T_IT20726" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_DB339_IT20722" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL044SQLAP_IT20726" #"\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_DB320_IT20726" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL044SQLAP_IT20726"  #"\\sbch-dp03br.sigi.us.selective.com\sql_prod3-Copy1" #"\\sbch-dp03br.sigi.us.selective.com\SQL_PROD3" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_COPS-DB810P_IT20700" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL055SQLAP_IT20793" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL047SQLC_IT20765" #"\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_COPS-DB768T_IT20700"   #"\\sbch-dp01br.sigi.us.selective.com\DESMOND"

$Account = "SIGI\AP729_LADM" #"SIGI\Cohesity_Storage_Users" #"SIGI\DL IT Application Delivery - Billing Operations" # "SIGI\Storage and Backup Engineers" #"SIGITEST\g-cops-db865t$" #"SIGITEST\s-IMSHDB05T_def" #"SIGI\KM_DSM_ETL" #"SIGI\KM_DSM_ETL" #"SIGI\viveks1"

$permissions = 'FullControl' #'FullControl' #'Read'
$inheritance = 'ContainerInherit, ObjectInherit'


Get-ChildItem -Directory -Path $path  -Recurse -Depth 0 -name | Sort-Object |fl | Out-File -FilePath "D:\Scripts\PS_Scripts\DirList.csv"


Start-Sleep -Seconds 1


ForEach ($Folder in $Folders) { 
$foldername = $($Folder.Foldername)

$acl = Get-Acl -Path $path\$foldername

$ace = New-Object Security.AccessControl.FileSystemAccessRule ($Account, $permissions, $inheritance, 'Inherit', 'Allow')
$acl.AddAccessRule($ace)
Set-Acl -AclObject $acl -Path $path\$foldername


}