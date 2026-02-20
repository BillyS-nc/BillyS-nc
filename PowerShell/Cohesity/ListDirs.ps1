
### setting variable for present working directory / get current directory ###
### this will be on your Selective Insuransce home drive e.g. "G:\PS_Scripts" ###
$PWDir="G:\PS_Scripts\"

### set present working directory for PowerShell session ###
 Set-Location $PWDir

### dot source api helper to pwd / cwd ###
#. .\cohesity-api.ps1


###List Directories, and subdirectories if recurse depth is specified #"-Recurse -Depth 1"  use 1 or greater for each level deeper in dir tree

#-Recurse -Depth 0

$Share= "\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL040SQLA_IT20794" #"\\sbch-dp01br.sigi.us.selective.com\SQL_TEST_BLAP-DB739T_IT20726" # "\\sbch-dp01br.sigi.us.selective.com\SQL_PROD_CL044SQLAP_IT20726" #"\\sbch-dp03br.sigi.us.selective.com\SQL_PROD3"

Get-ChildItem -Directory -Path $Share  -Recurse -Depth 0 -name | Sort-Object |fl | Out-File -FilePath "G:\PS_Scripts\DirList.csv"