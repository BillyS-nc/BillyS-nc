$registryPath = 'HKCU:\Software\Cohesity-API'

# ./cohesity-api.ps1 ; Get-ItemProperty -Path "$registryPath" -Name "sbch-dp04br.sigi.us.selective.com-LOCAL-api-test-False" -ErrorAction SilentlyContinue > "./pt-test_PW_RegKey2.txt"
#./cohesity-api.ps1 ; Get-ItemProperty -Path "$registryPath" -Name "sbch-dp01br.sigi.us.selective.com-LOCAL-api-test-False" -ErrorAction SilentlyContinue > "./apt-test_PW_RegKey2_2022-07-12.txt"


#api-test_pw_01_2022-07-12.txt


$ciphertextOLD_04= '01000000d08c9ddf0115d1118c7a00c04fc297eb01000000d5470cbf3cc5d144876e7241a1e5114e0000000002000000000003660000c00000001000000099969ae9386a09217155c0ff033f9b480000000004800000a00000001000000031a1f21aa6a2a9d845b73525771f03531800000019b61f9c2ac23634d26fcc7265598453becaa3e901b0d5bb14000000bd799082215d6c0e4280563c823bf2e1b2b3086b'
#$ciphertextNEW_01= '01000000d08c9ddf0115d1118c7a00c04fc297eb01000000d5470cbf3cc5d144876e7241a1e5114e0000000002000000000003660000c000000010000000b8e3a46f7d02c7f638caa7bd2af9ef610000000004800000a00000001000000040e006c8ff75af85d40bc0b8e101e690200000000c6666e9555c56a7f73470030c560ce364fb67278abc63c23b3047c9d968f7981400000063355d94d9c66dd7cee8cdf8b2e073f459773fec'
$ciphertextNEW_01= Get-Content ./api-test_pw_01_2022-07-12.txt
#$credential= '01000000d08c9ddf0115d1118c7a00c04fc297eb01000000d5470cbf3cc5d144876e7241a1e5114e0000000002000000000003660000c00000001000000099969ae9386a09217155c0ff033f9b480000000004800000a00000001000000031a1f21aa6a2a9d845b73525771f03531800000019b61f9c2ac23634d26fcc7265598453becaa3e901b0d5bb14000000bd799082215d6c0e4280563c823bf2e1b2b3086b'

#[PSCredential]::new('x', ('CIPHERTEXT_FROM_REGISTRY' | ConvertTo-SecureString)).GetNetworkCredential().Password  ## syntax from Paul

#[PSCredential]::new('x', ($ciphertext | ConvertTo-SecureString)).GetNetworkCredential().Password  > "C:\temp\api-test_converted_Password1_convertTo.txt"


################ GOOD THIS WORKS FOR THIS STEP TO DECRYPT ####
# [PSCredential]::new('x', ($ciphertextOLD_04 | ConvertTo-SecureString)).GetNetworkCredential().Password # > "C:\temp\api-test_converted_Password1_convertTo.txt"
[PSCredential]::new('x', ($ciphertextNEW_01 | ConvertTo-SecureString)).GetNetworkCredential().Password # > "C:\temp\api-test_converted_Password1_convertTo.txt"


###############################







