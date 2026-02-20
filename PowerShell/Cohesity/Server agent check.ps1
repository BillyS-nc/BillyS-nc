#Invoke-Command -ComputerName sbas-mg06brp -Authentication NegotiateWithImplicitCredential {get-service "Cohesity*";get-process -name *Cohesity* | Format-list -Property ProductVersion};driverquery /s copc-ap14t | Select-String -Pattern "CBTFLT"
driverquery /s sbas-mg06brp | Select-String -Pattern "CBTFLT"

Invoke-Command {get-service "Cohesity*";get-process -name *Cohesity* | Format-list -Property ProductVersion} -ComputerName sbas-mg06brp -Authentication NegotiateWithImplicitCredential


Set-Item WSMan:\localhost\Client\TrustedHosts -Value '<local>,*.selective.com,*.selectiveinsurance.com,10.*' -Force -Confirm:$false