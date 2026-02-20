$Servers = @(
    'adms-cd02t'
    'dbms-db391t'
)

foreach ($server in $Servers) {
"==== $server==="
#Checks for the existence of cbtflt system file.  Output may report up to 3 times
Invoke-Command -ComputerName $servers -au 3 -ScriptBlock {Test-Path -Path C:\Windows\System32\drivers\CBTFlt.sys}
#checks that filecbt and volcbt is installed
driverquery /s $server | Select-String -Pattern "CBTFLT"
#Checks registry value. If Value = 3, it needs to be reset to 0 and the server rebooted. Output may report up to 3 times
Invoke-Command -ComputerName $servers -au 3 -ScriptBlock {Get-ItemPropertyValue 'HKLM:\SYSTEM\CurrentControlSet\Services\CBTFlt\'-Name BSODTolerenceCounter}

}
