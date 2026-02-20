$Servers = @(
    'imms-ap04p'
    'imms-ap05p'
)

foreach ($server in $Servers) {
"==== $server==="
Invoke-Command -ComputerName $servers -au 3 -ScriptBlock {Get-ItemPropertyValue 'HKLM:\SYSTEM\CurrentControlSet\Services\CBTFlt\'-Name BSODTolerenceCounter}
}