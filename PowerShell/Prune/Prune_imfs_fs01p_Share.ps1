#Created and owned by Billy Smith 6/06/2025
#This script prunes the files on the associated NAS servers,
#in order to meet retention of test (15 days) and prod (45 days)

#Path of folder to prune
$Folder_cxpfiles_45d = "\\imfs-fs01p\Archive\archive_CXP_FILES_IT20706\CXP_FILES\45D"
$Folder_isofiles_45d = "\\imfs-fs01p\Archive\archive_ISO_FILES_IT20706\ISO_FILES\45D"
$Folder_recoveryxml_45d = "\\imfs-fs01p\Archive\archive_Recovery_XML_Files_IT20706\XML_FILES\45D"
$Folder_sog_45d = "\\imfs-fs01p\Archive\archive_SOG_PROSPECTS_IT20706\PROSPECTS_FILES\45D"
$Folder_vocftp_45d = "\\imfs-fs01p\Archive\archive_VOC_FTP_IT20706\VOC_FTP\45D"
$Folder_vocinbound_45d = "\\imfs-fs01p\Archive\archive_VOC_Inbound_IT20706\VOC_Inbound\45D"

#Path of log file for each archive
$Folder_cxpfiles_logs_45d = "\\imfs-fs01p\Archive\archive_CXP_FILES_IT20706\CXP_FILES\logs"
$Folder_isofiles_logs_45d = "\\imfs-fs01p\Archive\archive_ISO_FILES_IT20706\ISO_FILES\logs"
$Folder_recoveryxml_logs_45d = "\\imfs-fs01p\Archive\archive_Recovery_XML_Files_IT20706\XML_FILES\logs"
$Folder_sog_logs_45d = "\\imfs-fs01p\Archive\archive_SOG_PROSPECTS_IT20706\PROSPECTS_FILES\logs"
$Folder_vocftp_logs_45d = "\\imfs-fs01p\Archive\archive_VOC_FTP_IT20706\VOC_FTP\logs"
$Folder_vocinbound_logs_45d = "\\imfs-fs01p\Archive\archive_VOC_Inbound_IT20706\VOC_Inbound\logs"
$date = Get-Date -f yyyy-MM-dd_HHmm

#Name of log file for each retention window
$cxpfile45 = "\\imfs-fs01p\Archive\archive_CXP_FILES_IT20706\CXP_FILES\logs\deletedlog_45-"+$date+".txt"
$isofile45 = "\\imfs-fs01p\Archive\archive_ISO_FILES_IT20706\ISO_FILES\logs\deletedlog_45-"+$date+".txt"
$recoveryfile45 = "\\imfs-fs01p\Archive\archive_Recovery_XML_Files_IT20706\XML_FILES\logs\deletedlog_45-"+$date+".txt"
$sogfile45 = "\\imfs-fs01p\Archive\archive_SOG_PROSPECTS_IT20706\PROSPECTS_FILES\logs\deletedlog_45-"+$date+".txt"
$vocftpfile45 = "\\imfs-fs01p\Archive\archive_VOC_FTP_IT20706\VOC_FTP\logs\deletedlog_45-"+$date+".txt"
$vocinboundfile45 = "\\imfs-fs01p\Archive\archive_VOC_Inbound_IT20706\VOC_Inbound\logs\deletedlog_45-"+$date+".txt"


#Delete files older than 45 days
Write-Output "The following files were deleted on $date" | Out-File $cxpfile45
Get-ChildItem $Folder_cxpfiles_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $cxpfile45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $isofile45
Get-ChildItem $Folder_isofiles_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $isofile45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $recoveryfile45
Get-ChildItem $Folder_recoveryxml_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $recoveryfile45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $sogfile45
Get-ChildItem $Folder_sog_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $sogfile45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $vocftpfile45
Get-ChildItem $Folder_vocftp_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $vocftpfile45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $vocinboundfile45
Get-ChildItem $Folder_vocinbound_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $vocinboundfile45 -Append
}

#Delete logs older than 45 days
Write-Output "The following files were deleted on $date" | Out-File $cxpfile45
Get-ChildItem $Folder_cxpfiles_logs_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $cxpfile45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $isofile45
Get-ChildItem $Folder_isofiles_logs_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $isofile45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $recoveryfile45
Get-ChildItem $Folder_recoveryxml_logs_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $recoveryfile45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $sogfile45
Get-ChildItem $Folder_sog_logs_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $sogfile45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $vocftpfile45
Get-ChildItem $Folder_vocftp_logs_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $vocftpfile45 -Append
}

Write-Output "The following files were deleted on $date" | Out-File $vocinboundfile45
Get-ChildItem $Folder_vocinbound_logs_45d -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-45)} |
ForEach-Object {
   $_ | del -Force
   $_.FullName | Out-File $vocinboundfile45 -Append
}