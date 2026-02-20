
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
 $ViewPathSource = "G:\PS_Scripts\ViewPaths.csv"

 $subfolders1 = "13M" #"45D","6M","13M"
 $subfolders2 = "full", "inc", "log", "on-demand"
 #$Folders = Import-Csv D:\Folder\csv\Folders.csv 


 $Folders = Import-Csv $SourceCSV -header Foldername
 $viewPaths = Import-Csv $ViewPathSource -header path


 #$path = "G:\PS_Scripts\TEST_PROD_ENV\"

 ################# ADJUST THIS VARIABLE ################################################
 $path = "\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL047SQLC_IT20765"
 $testpath2 = "$path\$foldername"

 
  $foldername = $($Folder.Foldername)
  $testpathName = $($testpath.path)
  $viewpathName = $($viewpath.path)

 #"$path\$foldername\$subfolders1\$subfolders2"
 #"$path\$foldername\$subfolders1"


############################################################################################################################################################
### Confirming that the directory exists ( e.g. the "13M"  directory). If not, create it. ###


#### PS Script log entry ###
Start-Sleep -Milliseconds 500
Write-Host "Confirming that the 13M directory exists. If not, create it."

 Foreach ($viewPath in $ViewPaths) #($Folder in $Folders) #($subfolder1 in $subfolders1)  #($Folder in $Folders) #($testPath in $TestPaths)
   { $viewpathName = $($viewpath.path)
   Write-Host $viewpathName

  
if (Test-Path -path "$viewpathName")  #$path2\$subfolder1  #"G:\PS_Scripts\TEST_PROD_ENV\msdb\13M" #$path\$foldername  #"$testpathName"
{
   
   Write-Host "YES."


Write-host "wait 2 secs"

Start-sleep -s 2

Remove-Item $viewPathName -Force -Recurse



}
else
{   Write-host "NO......" #..............creating..."

##Write-host "wait 3 secs"

#Start-sleep -s 3

#New-Item $viewPathName -Type Directory 

#Remove-Item $viewPathName -Type Directory 


   
 
}
}