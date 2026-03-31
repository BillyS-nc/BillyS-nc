#Created and owned by Billy Smith 3/25/2025
#This script prunes the files on the associated NAS servers,
#in order to meet retention of test (15 days) and prod (45 days)

#Path of folder to prune
$Folder_45d = "\\cofs-fs01p\Procede\ProCede_Prod_45days"
$Folder_13M = "\\cofs-fs01p\Procede\ProCede_Prod_13mos"
$date = Get-Date -f yyyy-MM-dd_HHmm

#Name of file for each retention window
$file45 = "D:\Automation\DBRetentionGrooming\Logs\cofs-fs01p_45d\deletedlog_45-"+$date+".txt"
$file13mos = "D:\Automation\DBRetentionGrooming\Logs\cofs-fs01p_13mos\deletedlog_13mos-"+$date+".txt"

#Delete files older than 45 days
Write-Output "The following files were deleted on $date" | Out-File $file45
Get-ChildItem $Folder_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file45 -Append
}

#Delete files older than 13 months
Write-Output "The following files were deleted on $date" | Out-File $file13mos
Get-ChildItem $Folder_13M -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-395)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file13mos -Append
}