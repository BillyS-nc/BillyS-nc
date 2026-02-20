
### setting variable for present working directory / get current directory ###
### this will be on your Selective Insuransce home drive e.g. "G:\PS_Scripts" ###
$PWDir="G:\PS_Scripts\"

### set present working directory for PowerShell session ###
 Set-Location $PWDir

### dot source api helper to pwd / cwd ###
#. .\cohesity-api.ps1



################### create folders and subfolders

 #$SourceCSV = "G:\PS_Scripts\Folders.csv"
 $SourceCSV = "G:\PS_Scripts\DBfolders.csv"
 #$testPathSource = "G:\PS_Scripts\testpaths.csv"
 $ViewPathSource = "G:\PS_Scripts\ViewPaths.csv"

 $subfolders1 = "90D" #"13M" #"45D","6M","13M", #"90D"
 $subfolders2 = "full", "inc", "log", "on-demand"
 #$Folders = Import-Csv D:\Folder\csv\Folders.csv 



$Folders = Import-Csv $SourceCSV -header Foldername
 #$testPaths = Import-Csv $testPathSource -header path
$viewPaths = Import-Csv $ViewPathSource -header path

$foldername = $($Folder.Foldername)
#$testpathName = $($testpath.path)
$viewpathName = $($viewpath.path)

#$path = "G:\PS_Scripts\TEST_PROD_ENV\"
$path = "\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL044SQLAP_IT20726" #"\\sbch-dp01br.sigi.us.selective.com\DESMOND" #"\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL047SQLC_IT20765"
 #$testpath2 = "$path\$foldername"

 #"$path\$foldername\$subfolders1\$subfolders2"
 #"$path\$foldername\$subfolders1"


############################################################################################################################################################
### Confirming that the directory exists ( e.g. the "13M"  directory). If not, create it. ###


#### PS Script log entry ###
Start-Sleep -Milliseconds 500
Write-Host "Confirming that the 13M directory exists. If not, create it."

 Foreach ($viewPath in $viewPaths) #($Folder in $Folders) #($subfolder1 in $subfolders1)  #($Folder in $Folders) #($testPath in $TestPaths)
   { $viewpathName = $($viewpath.path)
   Write-Host $viewpathName

if (Test-Path "$viewPathName")  #$path2\$subfolder1  #"G:\PS_Scripts\TEST_PROD_ENV\msdb\13M" #$path\$foldername
{
   Write-Host "YES! Directory already exists."
Start-sleep -s 2

Write-host "wait 2 secs"
}

else

{   Write-host "NO....................creating..."

Write-host "wait 3 secs"

Write-Host "Confirming that log directory was created successfully."

Start-sleep -s 3

New-Item $viewPathName -Type Directory 


ForEach ($Folder in $Folders) { 
 $foldername = $($Folder.Foldername)
Test-path $path\$foldername

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

}
}

write-host "   
variable check   "

 write-host $path3

 write-host "   
variable check   "

 write-host $subfolders2

 write-host "   
variable check   "


  write-host $subfolders1

  write-host "   
variable check   "

 write-host $path

 
 write-host $path\$subfolder1


# write-host $path\$subfolders1
   

   




