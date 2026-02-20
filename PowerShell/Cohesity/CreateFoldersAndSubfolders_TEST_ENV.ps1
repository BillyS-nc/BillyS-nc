
### setting variable for present working directory / get current directory ###
### this will be on your Selective Insuransce home drive e.g. "G:\PS_Scripts" ###
$PWDir="G:\PS_Scripts\"

### set present working directory for PowerShell session ###
 Set-Location $PWDir

### dot source api helper to pwd / cwd ###
#. .\cohesity-api.ps1



################### create folders and subfolders


$subfolders1 = "15D"#,"6M","13M"
$subfolders2 = "full", "inc", "log", "on-demand"
$SourceCSV = "G:\PS_Scripts\DBfolders.csv"
 #$SourceCSV = "G:\PS_Scripts\Folders.csv"
 #$Folders = Import-Csv D:\Folder\csv\Folders.csv 
$Folders = Import-Csv $SourceCSV -header Foldername


#$path = "G:\PS_Scripts\TEST_ENV\"
$path = "\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_DB315_IT20794" #"\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_BLAP-DB739T_IT20726" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL047SQLC_IT20765"
ForEach ($Folder in $Folders) { 
  $foldername = $($Folder.Foldername)
New-Item $path\$foldername -type directory 
  Foreach ($subfolder in $subfolders1)
   { 
 $path2 = Join-Path $path\$foldername -ChildPath " ";
 New-Item $path2\$subfolder -Type Directory 
   }

 Foreach ($subfolder2 in $subfolders2)
   { 
 $path3 = Join-Path $path\$foldername\$subfolder -ChildPath " ";
 New-Item $path3\$subfolder2 -Type Directory 
   } 
   

}  



