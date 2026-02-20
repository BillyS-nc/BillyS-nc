## Download and install NetAppp modules for the first time - one time use ##
## Requires the use of the source.csv file ##
#Install-Module -Name NetApp.ONTAP -RequiredVersion 9.13.1.2306 -Scope CurrentUser

#Import-Module NetApp.ONTAP

## CONNECTING TO CLUSTER ##

$CLUSTER      = "10.165.0.26"
$CLUSTER_USER = "admin"
$CLUSTER_PASS = Read-Host "Cluster Password" -AsSecureString

$clu_creds = New-Object System.Management.Automation.PsCredential($CLUSTER_USER,$CLUSTER_PASS)
[Void](Add-NcCredential -Name $CLUSTER -Credential $clu_creds)
Connect-NcController $CLUSTER

## Storage and Domain parameters ##
$svm = $($Item.SVM)
$ipaddress = $($Item.IPAddress)
$interface = $($Item.Interface)
$exportname = $($Item.Exportname)
$protocol = $($Item.Protocol)
$exportpolicy = $($Item.Exportpolicy)
$security = $($Item.Security)
$client = $($Item.Client)
$vol = $($Item.Vol)
$domain = $($Item.domain)
$path = $($Item.Path)
$size = $($Item.Size)
$aggregate = $($Item.Aggregate)
$creds = Get-Credential

## CREATING DATA SVMS ##
#$PROVISION    = 100
#$DNS_DOMAIN   = "sigi.us.selective.com"
$DNS_SERVER   = "10.27.0.103,10.27.0.105"
#$LIF_NODE     = "C910-01"
$LIF_PORT     = "a0a-59"
#$NETWORK      = "10.59.100." #i.e. "10.10.2."
$NETMASK      = "255.255.0.0"


$Items = Import-Csv \\fs005\SBServicesTeam\PowerShell\NetApp\source-4.csv
ForEach ($Item in $Items){
#date;For($i=1;$i -le $PROVISION;$i++){[Void]
New-NcVserver -VserverName $($Item.svm) -RootVolumeAggregate $($Item.aggregate) -RootVolumeSecurityStyle $($Item.Security) -ZapiCall;date
#date;For($i=1;$i -le $PROVISION;$i++){[Void]
#New-NcNetDns -Domains $DNS_DOMAIN -NameServer $DNS_SERVER -VserverContext $($Item.svm) -SkipConfigValidation -ZapiCall;date
#date;For($i=1;$i -le $PROVISION;$i++){[Void]
#New-NcNetInterface -Name "$($Item.svm) + _lif1" -vserver $($Item.svm) -Role data -Node $($Item.aggregate) -Port $LIF_PORT -DataProtocols cifs,nfs -Address $($Item.ipaddress) -NetMask $NETMASK -ZapiCall;date
#New-NcNetRoute -Destination 0.0.0.0/0 -Gateway 10.59.0.3 -VserverContext $($Item.svm)

## CREATING CIFS SERVERS ##

#$OU        = "ou=Computers,ou=NetApp NAS servers"

#Add-NcCifsServer -VserverContext $($Item.svm) -Name $($Item.svm) -Domain $($Item.domain) -AdminUsername $creds.UserName -AdminPassword $creds.GetNetworkCredential().Password -OrganizationalUnit $OU
#date;For($i=1;$i -le $PROVISION;$i++){[Void]

#Create Volume
Connect-NcController $CLUSTER -Vserver $($Item.svm) -Credential $clu_cred
New-NcVol -Name $($Item.vol) -Aggregate $($Item.aggregate) -Size $($Item.size) -JunctionPath $($Item.path) -SecurityStyle $($Item.security) -Encrypt

#Create and assign export policy
#New-NcExportPolicy -VserverContext $($Item.svm) -Name $($Item.exportname)
#New-NcExportRule -VserverContext $($Item.svm) -Policy $($Item.exportpolicy) -ClientMatch $($Item.client) -ReadOnlySecurityFlavor any -ReadWriteSecurityFlavor any -SuperUserSecurityFlavor any
#Update-NcVol -Query @{name="$($Item.vol)"} -Attributes @{volumeexportattributes=@{policy="$($Item.exportpolicy)"}}

#Create share
#Add-NcCifsShare -Name $($Item.vol)  -Path $($Item.path)
}


## Remove Volume\SVM ##
#Remove-NcVol -Name $($Item.vol) -Confirm:$false
#Remove-NcVserver -Name $($Item.svm) -Confirm:$false
