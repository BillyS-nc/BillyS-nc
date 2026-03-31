#Created and owned by Billy Smith 6/06/2025
#This script prunes the files on the associated NAS servers,
#in order to meet retention of test (15 days) and prod (45 days)

#Path of folder to prune
$Folder_direct_45d = "\\sbfs-fs01p\data\billing_nightly_direct\IT20726\45D"
$Folder_flood_45d = "\\sbfs-fs01p\data\billing_nightly_flood\IT20726\45D"
$Folder_cancel_45d = "\\sbfs-fs01p\data\jobcancel\IT20726\45D"
$Folder_misc_45d = "\\sbfs-fs01p\data\jobmisc\IT20726\45D"
$Folder_commission_12M = "\\sbfs-fs01p\data\archive_commission\IT20726\365D"
$Folder_company_12M = "\\sbfs-fs01p\data\archive_company\IT20726\365D"
$Folder_direct_logs_45d = "\\sbfs-fs01p\data\billing_nightly_direct\IT20726\Logs"
$Folder_flood_logs_45d = "\\sbfs-fs01p\data\billing_nightly_flood\IT20726\Logs"
$Folder_cancel_logs_45d = "\\sbfs-fs01p\data\jobcancel\IT20726\Logs"
$Folder_misc_logs_45d = "\\sbfs-fs01p\data\jobmisc\IT20726\Logs"
$Folder_commission_logs_12M = "\\sbfs-fs01p\data\archive_commission\IT20726\Logs"
$Folder_company_logs_12M = "\\sbfs-fs01p\data\archive_company\IT20726\Logs"
$date = Get-Date -f yyyy-MM-dd_HHmm

#Name of log file for each retention window
$file45 = "D:\Automation\DBRetentionGrooming\Logs\sbfs-fs01p_45d\deletedlog_45-"+$date+".txt"
$file12mos = "D:\Automation\DBRetentionGrooming\Logs\sbfs-fs01p_13mos\deletedlog_12mos-"+$date+".txt"


#Delete files older than 45 days
Write-Output "The following files were deleted on $date" | Out-File $file45
Get-ChildItem $Folder_direct_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $file45
Get-ChildItem $Folder_flood_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $file45
Get-ChildItem $Folder_cancel_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $file45
Get-ChildItem $Folder_misc_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file45 -Append
}


#Delete logs older than 45 days
Write-Output "The following files were deleted on $date" | Out-File $file45
Get-ChildItem $Folder_direct_logs_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $file45
Get-ChildItem $Folder_flood_logs_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $file45
Get-ChildItem $Folder_cancel_logs_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $file45
Get-ChildItem $Folder_misc_logs_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file45 -Append
}


#Delete files older than 12 months
Write-Output "The following files were deleted on $date" | Out-File $file13mos
Get-ChildItem $Folder_commission_12M -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-365)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file13mos -Append
}

Write-Output "The following files were deleted on $date" | Out-File $file13mos
Get-ChildItem $Folder_company_12M -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-365)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file13mos -Append
}

#Delete logs older than 12 months
Write-Output "The following files were deleted on $date" | Out-File $file13mos
Get-ChildItem $Folder_commission_logs_12M -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-365)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file13mos -Append
}

Write-Output "The following files were deleted on $date" | Out-File $file13mos
Get-ChildItem $Folder_company_logs_12M -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-365)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file13mos -Append
}