
### setting variable for present working directory / get current directory ###
### this will be on your Selective Insuransce home drive e.g. "G:\PS_Scripts" ###
$PWDir="G:\PS_Scripts\"

### set present working directory for PowerShell session ###
 Set-Location $PWDir

### dot source api helper to pwd / cwd ###
#. .\cohesity-api.ps1



################### create folders and subfolders

 $SourceCSV = "G:\PS_Scripts\Folders.csv"
 $testPathSource = "G:\PS_Scripts\testpaths.csv"

 $subfolders1 = "13M" #"45D","6M","13M"
 $subfolders2 = "full", "inc", "log", "on-demand"
 #$Folders = Import-Csv D:\Folder\csv\Folders.csv 

  $foldername = $($Folder.Foldername)
  $testpathName = $($testpath.path)

 $Folders = Import-Csv $SourceCSV -header Foldername
 $testPaths = Import-Csv $testPathSource -header path


 $path = "G:\PS_Scripts\TEST_PROD_ENV\"
 $testpath2 = "$path\$foldername"

 #"$path\$foldername\$subfolders1\$subfolders2"
 #"$path\$foldername\$subfolders1"


############################################################################################################################################################
### Confirming that the directory exists ( e.g. the "13M"  directory). If not, create it. ###


#### PS Script log entry ###
Start-Sleep -Milliseconds 500
Write-Host "Confirming that the 13M directory exists. If not, create it."

 Foreach ($testPath in $TestPaths) #($Folder in $Folders) #($subfolder1 in $subfolders1)  #($Folder in $Folders) #($testPath in $TestPaths)
   { $testpathName = $($testpath.path)
   Write-Host $testpathName

if (Test-Path "$testPathName")  #$path2\$subfolder1  #"G:\PS_Scripts\TEST_PROD_ENV\msdb\13M" #$path\$foldername
{
   Write-Host "YES! Directory already exists."
Start-sleep -s 2

Write-host "wait 2 secs"
}
else
{
 Write-host " 
 Creating Directories as needed
 wait 3 secs
 " 

 Start-sleep -s 3

    #PowerShell Create directory if not exists
    #New-Item $Dir$LogDir -ItemType Directory
    #WriteToLogFile "Confirming that log directory was created successfully."

 ForEach ($Folder in $Folders) { 
 $foldername = $($Folder.Foldername)
Test-Path $path\$foldername

 Foreach ($subfolder1 in $subfolders1)
   { 
 $path2 = Join-Path $path\$foldername -ChildPath " ";
 New-Item $path2\$subfolders1 -Type Directory 
   
   Foreach ($subfolder2 in $subfolders2)
 {  
 $path3 = Join-Path $path\$foldername\$subfolder1 -ChildPath " ";
 New-Item $path3\$subfolder2 -Type Directory 
   }
   
Write-Host "Confirming that log directory was created successfully."
   }
   }
   }
   }
   




