## Download and install NetAppp modules for the first time - one time use ##
## Requires the use of the source.csv file ##
#Install-Module -Name NetApp.ONTAP -RequiredVersion 9.13.1.2306

Import-Module NetApp.ONTAP

## CONNECTING TO CLUSTER ##

$CLUSTER      = "<IP or hostname>"
$CLUSTER_USER = "<admin user>"
$CLUSTER_PASS = Read-Host "Cluster Password" -AsSecureString

$clu_creds = New-Object System.Management.Automation.PsCredential($CLUSTER_USER,$CLUSTER_PASS)
[Void](Add-NcCredential -Name $CLUSTER -Credential $clu_creds)
Connect-NcController $CLUSTER


$svm = $($Item.SVM)
$ipaddress = $($Item.IPAddress)
$interface = $($Item.Interface)
$exportname = $($Item.Exportname)
$protocol = $($Item.Protocol)
$exportpolicy = $($Item.Exportpolicy)
$client = $($Item.Client)
$vol = $($Item.Vol)
$path = $($Item.Path)


## CREATING DATA SVMS ##
#$VSERVER = $svm
$AGGREGATE    = "<Aggregate_or_Tier_name>"
#$PROVISION    = 100
$DNS_DOMAIN   = "<Domain_name>"
$DNS_SERVER   = "<DNS_IP>"
#$LIF_NODE     = "C910-01"
$LIF_PORT     = "<LIF_Port>"
$NETWORK      = "<network" #i.e. "10.10.2."
$NETMASK      = "<netmask>"

$Items = Import-Csv "\\serve1\billys\NetApp\powershell\source.csv"
ForEach ($Item in $Items){
#date;For($i=1;$i -le $PROVISION;$i++){[Void]
New-NcVserver -VserverName $($Item.svm) -RootVolumeAggregate $($Item.AGGREGATE) -RootVolumeSecurityStyle ntfs -ZapiCall;date
#date;For($i=1;$i -le $PROVISION;$i++){[Void]
New-NcNetDns -Domains $DNS_DOMAIN -NameServer $DNS_SERVER -VserverContext $($Item.svm) -SkipConfigValidation -ZapiCall;date
#date;For($i=1;$i -le $PROVISION;$i++){[Void]
New-NcNetInterface -Name "$($Item.svm) + _lif1" -vserver $($Item.svm) -Role data -Node NetApp2-01 -Port $LIF_PORT -DataProtocols $($Item.protocol) -Address $($Item.ipaddress) -NetMask $NETMASK -ZapiCall;date

## CREATING CIFS SERVERS ##

$AD_USER   = "administrator"
$AD_PASS   = Read-Host "AD User Password" -AsSecureString
$OU        = "CN=computers"

$ad_creds = Add-NcCifsServer -VserverContext $($Item.svm) -Name $($Item.svm) -Domain $DNS_DOMAIN -AdminCredential $AD_USER -OrganizationalUnit $OU
#date;For($i=1;$i -le $PROVISION;$i++){[Void]

#Create Volume
Connect-NcController $CLUSTER -Vserver $($Item.svm) -Credential $cred
New-NcVol -Name $($Item.vol) -Aggregate $AGGREGATE -Size 1GB -JunctionPath $($Item.path) -SecurityStyle ntfs

#Create and assign export policy
New-NcExportPolicy -VserverContext $($Item.svm) -Name $($Item.exportname)
New-NcExportRule -VserverContext $($Item.svm) -Policy $($Item.exportpolicy) -ClientMatch $($Item.client) -ReadOnlySecurityFlavor any -ReadWriteSecurityFlavor any -SuperUserSecurityFlavor any
Update-NcVol -Query @{name="$($Item.vol)"} -Attributes @{volumeexportattributes=@{policy="$($Item.exportpolicy)"}}

#Create share
Add-NcCifsShare -Name $($Item.vol)  -Path $($Item.path)
}