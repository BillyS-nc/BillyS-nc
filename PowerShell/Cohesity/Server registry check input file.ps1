$Servers = @(Get-Content L:\Billy\PowerShell_scripts\server_list.txt
)

foreach ($server in $Servers) {
"==== $server==="
#Checks for the existence of cbtflt system file.  Output reports 3 times
Invoke-Command -ComputerName $servers -au 3 -ScriptBlock {Test-Path -Path C:\Windows\System32\drivers\CBTFlt.sys}
#checks that filecbt and volcbt is installed
driverquery /s $server | Select-String -Pattern "CBTFLT"
#Checks registry value. If Value = 3, it needs to be reset to 0 and the server rebooted. Output reports 3 times
Invoke-Command -ComputerName $servers -au 3 -ScriptBlock {Get-ItemPropertyValue 'HKLM:\SYSTEM\CurrentControlSet\Services\CBTFlt\'-Name BSODTolerenceCounter}

}
