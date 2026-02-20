<#
.SYNOPSIS
    This will set unprotected databases to the defined SLA.
#>

[cmdletbinding()]
param(
    [string]$serviceAccountFile='L:\Billy\PowerShell_scripts\Rubrik\json\s-rubrik-powershell.json'
)

function Write-Log() {
    param ( $message, [switch]$isError, [switch]$isSuccess, [switch]$isWarning )
    $color = 'Blue'
    if($isError){
        $message = 'ERROR: ' + $message
        $color = 'red'
    } elseif($isSuccess){
        $message = 'SUCCESS: ' + $message
        $color = 'green'
    } elseif($isWarning){
        $message = 'WARNING: ' + $message
        $color = 'yellow'
    }
    $message = "$(get-date) $message"
    Write-Host("$message$($PSStyle.Reset)") -BackgroundColor $color
    $message | out-file host_sla_log.txt -append
    if($isError) { exit }
}

function Connect-RSC {

  #The following lines are for brokering the connection to RSC
  #Test the service account json for valid json content
  try {
      Get-Content $serviceAccountFile | ConvertFrom-Json | out-null
  }
  catch {
      Write-Log -message 'Service Account Json is not valid, please redownload from Rubrik Security Cloud' -isError
  }

  #Convert the service account json to a PowerShell object
  $serviceAccountJson = Get-Content $serviceAccountFile | convertfrom-json

  #Create headers for the initial connection to RSC
  $headers = @{
      'Content-Type' = 'application/json';
      'Accept'       = 'application/json';
  }

  #Create payload to send for authentication to RSC
  $payload = @{
      grant_type    = "client_credentials";
      client_id     = $serviceAccountJson.client_id;
      client_secret = $serviceAccountJson.client_secret
  } 

  #Try to send payload through to RSC to get bearer token
  try {
      $response = Invoke-RestMethod -Method POST -Uri $serviceAccountJson.access_token_uri -Body $($payload | ConvertTo-JSON -Depth 100) -Headers $headers
  }
  catch {
      Write-Log -message "Failed to authenticate, check the contents of the service account json, and ensure proper permissions are granted" -isError
  }

  #Create connection object for all subsequent calls with bearer token
  $connection = [PSCustomObject]@{
      headers = @{
          'Content-Type'  = 'application/json';
          'Accept'        = 'application/json';
          'Authorization' = $('Bearer ' + $response.access_token);
      }
      endpoint = $serviceAccountJson.access_token_uri.Replace('/api/client_token', '/api/graphql')
  }
  #End brokering to RSC
  Write-Log -message 'Authentication to RSC succeeded'
  $global:connection = $connection
  return $connection
}

$rsc = Connect-Rsc

# This will set unprotected databases to the defined SLA

Get-RubrikDatabase

#Get-RubrikDatabase | Where {$_.effectiveSlaDomainId -eq 'UNPROTECTED'} | Protect-RubrikDatabase -SLA Bronze -WhatIf

#Get-RubrikDatabase | Where {$_.effectiveSlaDomainId -eq 'UNPROTECTED'} | Protect-RubrikDatabase -SLA Bronze -confirm:$false

#Get-RubrikDatabase | Where {$_.effectiveSlaDomainId -eq 'UNPROTECTED'} | Protect-RubrikDatabase -SLA Bronze -confirm:$false


