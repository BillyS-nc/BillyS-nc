#powershell.exe -Command ". cohesity-api.ps1 ; getpwd -vip sbch-dp04brp.selective.com -username s-cohesity-batch -domain sigi.us.selective.com > C:\temp\out.txt"



   # $keyName = "$vip`-$domain`-$username`-$useApiKey"
   # $altKeyName = "$vip`:$domain`:$username`:$useApiKey"
#Get-CohesityAPIPassword


#Windows
    # old format    #$storedPassword = Get-ItemProperty -Path "$registryPath" -Name "$keyName" -ErrorAction SilentlyContinue
       

$registryPath = 'HKCU:\Software\Cohesity-API'

  #  ./cohesity-api.ps1 ; Get-ItemProperty -Path "$registryPath" -Name "sbch-dp04br.sigi.us.selective.com-LOCAL-api-test-False" -ErrorAction SilentlyContinue > "C:\temp\apt-test_PW_RegKey1.txt"

  
#./cohesity-api.ps1 ; Get-CohesityAPIPassword -vip sbch-dp01brp.selective.com -username api-test -domain LOCAL > "./api-test_PW_out_run2.txt"


#function Get-CohesityAPIPassword($vip='helios.cohesity.com', $username='helios', $domain='local', $useApiKey=$false, $helios=$false)


#[PSCredential]::new('x', ('CIPHERTEXT_FROM_REGISTRY' | ConvertTo-SecureString)).GetNetworkCredential().Password  ## syntax from Paul



 
#$SecurePasswordtxt = '01000000d08c9ddf0115d1118c7a00c04fc297eb01000000d5470cbf3cc5d144876e7241a1e5114e0000000002000000000003660000c00000001000000099969ae9386a09217155c0ff033f9b480000000004800000a00000001000000031a1f21aa6a2a9d845b73525771f03531800000019b61f9c2ac23634d26fcc7265598453becaa3e901b0d5bb14000000bd799082215d6c0e4280563c823bf2e1b2b3086b'
#$passwd = '01000000d08c9ddf0115d1118c7a00c04fc297eb01000000d5470cbf3cc5d144876e7241a1e5114e0000000002000000000003660000c00000001000000099969ae9386a09217155c0ff033f9b480000000004800000a00000001000000031a1f21aa6a2a9d845b73525771f03531800000019b61f9c2ac23634d26fcc7265598453becaa3e901b0d5bb14000000bd799082215d6c0e4280563c823bf2e1b2b3086b'

#$ciphertext = = '01000000d08c9ddf0115d1118c7a00c04fc297eb01000000d5470cbf3cc5d144876e7241a1e5114e0000000002000000000003660000c00000001000000099969ae9386a09217155c0ff033f9b480000000004800000a00000001000000031a1f21aa6a2a9d845b73525771f03531800000019b61f9c2ac23634d26fcc7265598453becaa3e901b0d5bb14000000bd799082215d6c0e4280563c823bf2e1b2b3086b'


#ConvertFrom-SecureString $SecurePasswordtxt > "C:\temp\api-test_converted_Password1.txt"


# $securePassword = ConvertTo-SecureString -String $passwd -AsPlainText -Force
#                $encryptedPasswordText = $securePassword | ConvertFrom-SecureString > "C:\temp\api-test_converted_Password1.txt"



## Convert the ciphertext into a live SecureString, then decrypt that into normal text:

##[PSCredential]::new('x', ($ciphertext | ConvertTo-SecureString)).GetNetworkCredential().Password # > "C:\temp\api-test_converted_Password1_convertTo.txt"


#$credential.GetNetworkCredential() | fl * #> "C:\temp\test1.txt"

#$ciphertext.GetNetworkCredential() | fl * # > "C:\temp\test1.txt"

################################################################## trying again.. second attempt on Monday 7/11/2022 #####

#### wrapper for script UnProtect_Physical.ps1
####  NOTE: per Brian Seltzer, the Cohesity protectGenericNas.ps1 script is primarily intended to create new jobs not for modifying existing protection groups.
###   If use to modify or update an existing protection group, not all features will work. e.g. some properties like include and exclude lists will not be updated. membership will be updated #####

### setting variable for present working directory / get current directory ###
### this will be on your Selective Insuransce home drive e.g. "G:\PS_Scripts" ###
$PWDir="G:\PS_Scripts\"

### set present working directory for PowerShell session ###
 Set-Location $PWDir

### dot source api helper to pwd / cwd ###
. .\cohesity-api.ps1


#### getting the password

#./cohesity-api.ps1 ; 

#Get-CohesityAPIPassword -vip sbch-dp01br.selective.com -username api-test -domain LOCAL | Out-File -Encoding "UTF8" -FilePath ./api-test_PW_out_run5.txt

#Get-Content ./api-test_PW_out_run5.txt

#apiauth -vip sbch-dp01br.selective.com -username api-test -domain LOCAL -passwd $(Get-Content ./api-test_PW_out_run5.txt)


$PasswordRef= Get-Content ./api-test_pw_apiauth_tst1.txt
Write-Host $PasswordRef
$Pass='Coh351ty_t3st'

#$ConvertPasswordRef=Get-Content ./api-test_pw_apiauth_tst1.txt | ConvertTo-Json -AsArray
#Write-Host $ConvertPasswordRef
apiauth -vip sbch-dp01br.selective.com -username api-test -domain LOCAL -passwd $(Get-Content G:\PS_Scripts\api-test_pw_apiauth_tst1.txt)


