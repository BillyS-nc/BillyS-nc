#$inputFile = G:\PowerShell_scripts\server_list.txt
#$outputFile = G:\PowerShell_scripts\output.txt
#Get-Content G:\PowerShell_scripts\server_list.txt | out-file G:\PowerShell_scripts\output.txt

#Invoke-Command -ComputerName (Get-Content G:\PowerShell_scripts\server_list.txt) {get-service "Cohesity*";get-process -name *Cohesity* | Format-list -Property ProductVersion};#driverquery /s imms-ap04p | Select-String -Pattern "CBTFLT"

#Invoke-Command -ComputerName (Get-Content G:\PowerShell_scripts\server_list.txt) {get-service "Cohesity*";get-process -name *Cohesity* | Format-list -Property ProductVersion;get-wmiobject win32_pnpsigneddriver | Select DeviceName, DriverVersion | Select-String "CBTFLT"}

#driverquery /s imms-ap04p;imms-ap05p | Select-String -Pattern "CBTFLT"

#driverquery | Select-String -Pattern "CBTFLT"

#driverquery /s G:\PowerShell_scripts\server_list.txt | Select-String -Pattern "CBTFLT"

Invoke-Command -ComputerName imms-ap04p {Get-WmiObject win32_driverfordevice} > G:\PowerShell_scripts\output.txt

#Invoke-Command -ComputerName (Get-Content G:\PowerShell_scripts\server_list.txt) {get-service "Cohesity*";get-process -name *Cohesity* | Format-list -Property ProductVersion} > G:\PowerShell_scripts\output.txt

Invoke-Command -ComputerName imsh-cd07t.sigitest.ustest.selective.com {Get-WindowsDriver -Online -All}

Get-WindowsDriver -Online -Al