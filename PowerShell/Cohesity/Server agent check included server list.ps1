$Servers = @(
    'plpl-cd003p'
)

Invoke-Command -ComputerName $Servers -au 3 {get-service "Cohesity*";get-process -name *Cohesity* | Format-list -Property ProductVersion}

foreach ($server in $Servers) {
    "=== $server ==="
    driverquery /s $server | Select-String -Pattern "CBTFLT"
}