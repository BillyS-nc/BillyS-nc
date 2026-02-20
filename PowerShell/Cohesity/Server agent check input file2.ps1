Start-Transcript G:\PowerShell_scripts\output.txt
$Servers = @(Get-Content G:\PowerShell_scripts\server_list.txt
)

Invoke-Command -ComputerName (Get-Content G:\PowerShell_scripts\server_list.txt) {get-service "Cohesity*";get-process -name *Cohesity* | Format-list -Property ProductVersion}
 foreach ($server in $Servers) {
    "=== $server ==="
    driverquery /s $server | Select-String -Pattern "CBTFLT"
}
Stop-Transcript