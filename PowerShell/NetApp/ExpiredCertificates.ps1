###
# To run the script type the following in the Powershell CLI:
#
# ntapaddshareacl.ps1 -sharename  -ugname  -shareperms <no_access,full_control,read or change> -svmname 
# (.\ntapaddshareacl.ps1 -sharename test123 -ugname domain\user -shareperms reaad -svmname marctone
# The values will be passed into a for loop and add the users or groups listed in the ugname parameter to the command add-nccifsshareacl
# 
###

## CONNECTING TO CLUSTER ##

$CLUSTER      = "10.165.0.26"
$CLUSTER_USER = "admin"
$CLUSTER_PASS = Read-Host "Cluster Password" -AsSecureString

$clu_creds = New-Object System.Management.Automation.PsCredential($CLUSTER_USER,$CLUSTER_PASS)
[Void](Add-NcCredential -Name $CLUSTER -Credential $clu_creds)
Connect-NcController $CLUSTER

## option parameters ##
#Get-NcSecuritySsl
#Get-NcSecurityCertificate

## Get Security Certificate information ##
#Get-NcSecurityCertificate | select * | select -
#Get-NcSecurityCertificate | Select * | Select Vserver,CommonName,SerialNumber,Type,ExpirationDate > L:\PowerShell\NetApp\Output\expiredcert.csv

## Create new certificate ##
#New-NcSecurityCertificate -Type server -CommonName $CommonName -Size 2048 -ExpireDays 365 -HashFunction SHA256 -Vserver $vserver

## Identify new certificate ##
# Get-NcSecurityCertificate | Select * | Select Vserver,CommonName,SerialNumber,Type,ExpirationDate > L:\PowerShell\NetApp\Output\expiredcert.csv

## Enable new certificate ##
# 

## Renew certificate ##
#.\NetAppSSLCertificateRenew.ps11 -Cluster 10.165.0.26 -Username admin -Password
