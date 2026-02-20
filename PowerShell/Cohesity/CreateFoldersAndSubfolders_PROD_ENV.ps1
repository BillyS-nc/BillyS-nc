
### setting variable for present working directory / get current directory ###
### this will be on your Selective Insuransce home drive e.g. "G:\PS_Scripts" ###
$PWDir="D:\Scripts\PS_Scripts\"

### set present working directory for PowerShell session ###
 Set-Location $PWDir

### dot source api helper to pwd / cwd ###
#. .\cohesity-api.ps1



################### create folders and subfolders



$SourceCSV = "D:\Scripts\PS_Scripts\DBfolders.csv"
$subfolders1 = "45D" #"13M" #,"6M","13M", "45D" 
$subfolders2 = "full", "inc", "log", "on-demand"


#$Folders = Import-Csv D:\Folder\csv\Folders.csv 
# $SourceCSV = "G:\PS_Scripts\Folders.csv"
$Folders = Import-Csv $SourceCSV -header Foldername

 #$path = "G:\PS_Scripts\TEST_PROD_ENV\"
$path = "\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL091SQLAP" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL047SQLB_IT20765" #"\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_CL061TL1_IT20700"  #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL047SQLC_IT20765"



ForEach ($Folder in $Folders) { 
 $foldername = $($Folder.Foldername)
New-Item $path\$foldername -type Directory 

  Foreach ($subfolder1 in $subfolders1)
   { 
 $path2 = Join-Path $path\$foldername -ChildPath " ";
 New-Item $path2\$subfolder1 -Type Directory 
   
   Foreach ($subfolder2 in $subfolders2)
   { 
 $path3 = Join-Path $path\$foldername\$subfolder1 -ChildPath " ";
 New-Item $path3\$subfolder2 -Type Directory 
   }
   }
   }



 ##### sleep

############################################################################################################################################################
### Confirming that the directory exists ( e.g. the "13M"  directory). If not, create it. ###

 