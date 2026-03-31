#Path of folder to prune

$Folder_isofiles_45d = "\\imfs-fs01p\Archive\archive_ISO_FILES_IT20706\ISO_FILES\45D"

#Name of log file for each retention window
$file45 = "D:\Cohesity\Archive\Pruning\Logs\imfs-fs01p_45d\deletedlog_45-"+$date+".txt"
#$file12mos = "D:\Automation\DBRetentionGrooming\Logs\sbfs-fs01p_13mos\deletedlog_12mos-"+$date+".txt"


#Delete files older than 45 days


Write-Output "The following files were deleted on $date" | Out-File $file45
Get-ChildItem $Folder_isofiles_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $file45 -Append
}

