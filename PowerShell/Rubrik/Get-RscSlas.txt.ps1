<#
.SYNOPSIS
    Pulls all SLAs from RSC and generates a report containing their parameters.
.EXAMPLE
    .\Get-RscSlas -serviceAccountFile ..\sa.json
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



function Get-RscSlas() {
    $payload = @{
        query = 'query {
  slaDomains {
    nodes {
      id
      name
      ... on GlobalSlaReply {
        isDefault
        description
        snapshotSchedule {
          minute {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
          }
          hourly {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
          }
          daily {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
          }
          weekly {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
            dayOfWeek
          }
          monthly {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
            dayOfMonth
          }
          quarterly {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
            dayOfQuarter
            quarterStartMonth
          }
          yearly {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
            dayOfYear
            yearStartMonth
          }
        }
        archivalSpecs {
          threshold
          thresholdUnit
          storageSetting {
            id
            name
            groupType
          }
          archivalTieringSpec {
            coldStorageClass
            minAccessibleDurationInSeconds
            isInstantTieringEnabled
          }
        }
        backupWindows {
          durationInHours
          startTimeAttributes {
            hour
            minute
          }
        }
        firstFullBackupWindows {
          durationInHours
          startTimeAttributes {
            dayOfWeek {
              day
            }
            hour
            minute
          }
        }
        replicationSpecsV2 {
          replicationLocalRetentionDuration {
            duration
            unit
          }
          cascadingArchivalSpecs {
            archivalTieringSpec {
              coldStorageClass
              shouldTierExistingSnapshots
              minAccessibleDurationInSeconds
              isInstantTieringEnabled
            }
            archivalLocation {
              id
              name
              targetType
              ... on RubrikManagedAwsTarget {
                immutabilitySettings {
                  lockDurationDays
                }
              }
              ... on RubrikManagedAzureTarget {
                immutabilitySettings {
                  lockDurationDays
                }
              }
              ... on RubrikManagedNfsTarget {
                host
              }
              ... on CdmManagedAwsTarget {
                immutabilitySettings {
                  lockDurationDays
                }
              }
              ... on CdmManagedAzureTarget {
                immutabilitySettings {
                  lockDurationDays
                }
              }
            }
            frequency
            archivalThreshold {
              duration
              unit
            }
          }
          retentionDuration {
            duration
            unit
          }
          cluster {
            id
            name
          }
          targetMapping {
            id
            name
          }
          awsTarget {
            accountId
            accountName
            region
          }
          azureTarget {
            region
          }
        }
        localRetentionLimit {
          duration
          unit
        }
        objectSpecificConfigs {
          sapHanaConfig {
            incrementalFrequency {
              duration
              unit
            }
            differentialFrequency {
              duration
              unit
            }
            logRetention {
              duration
              unit
            }
          }
          awsRdsConfig {
            logRetention {
              duration
            }
          }
          vmwareVmConfig {
            logRetentionSeconds
          }
        }
        clusterToSyncStatusMap {
          clusterUuid
          slaSyncStatus
        }
        objectTypes
        upgradeInfo {
          eligibility {
            isEligible
            ineligibilityReason
          }
          latestUpgrade {
            status
            msg
          }
        }
        allOrgsHavingAccess {
          id
          name
        }
        ownerOrg {
          id
          name
        }
        isRetentionLockedSla
      }
      ... on ClusterSlaDomain {
        cdmId
        name
        cluster {
          name
          version
        }
        snapshotSchedule {
          minute {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
          }
          hourly {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
          }
          daily {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
          }
          weekly {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
            dayOfWeek
          }
          monthly {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
            dayOfMonth
          }
          quarterly {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
            dayOfQuarter
            quarterStartMonth
          }
          yearly {
            basicSchedule {
              frequency
              retention
              retentionUnit
            }
            dayOfYear
            yearStartMonth
          }
        }
        backupWindows {
          durationInHours
          startTimeAttributes {
            hour
            minute
          }
        }
        firstFullBackupWindows {
          durationInHours
          startTimeAttributes {
            dayOfWeek {
              day
            }
            hour
            minute
          }
        }
        archivalSpec {
          threshold
          thresholdUnit
          archivalLocationName
          archivalLocationId
          archivalTieringSpec {
            coldStorageClass
            minAccessibleDurationInSeconds
            isInstantTieringEnabled
          }
        }
        replicationSpecsV2 {
          retentionDuration {
            duration
            unit
          }
          cluster {
            id
            name
          }
          targetMapping {
            id
            name
          }
          awsTarget {
            accountId
            accountName
            region
          }
          azureTarget {
            region
          }
        }
        localRetentionLimit {
          duration
          unit
        }
        upgradeInfo {
          eligibility {
            isEligible
            ineligibilityReason
          }
          latestUpgrade {
            status
            msg
          }
        }
        ownerOrg {
          id
          name
        }
        isRetentionLockedSla
      }
    }
    pageInfo {
      endCursor
      hasNextPage
    }
  }
}'
    }
    $response = (Invoke-RestMethod -Method POST -Uri $rsc.endpoint -Body $($payload | ConvertTo-JSON -Depth 100) -Headers $rsc.headers).data
    if($null -eq $response){
        Write-Log -isError ('There was an issue querying slas, please ensure that you have permissions to view SLAs.')
    } else {
        if($null -eq $response){
            Write-Log -isError ('There was an attempt...')
        } else {
            Write-Log ('Found {0} SLAs' -f $response.sladomains.nodes.Count)
            return $response
        }
    }
}

$rsc = Connect-Rsc
$slas = Get-RscSlas

$slas.slaDomains.nodes | % {
    [PSCustomObject] @{
        id = $_.id
        name = $_.name
        object_type = $_.objecttypes[0]
        description = $_.description

        minute_frequency = $_.snapshotSchedule.minute.basicschedule.frequency
        minute_retention = $_.snapshotSchedule.minute.basicschedule.retention
        minute_unit = $_.snapshotSchedule.minute.basicschedule.retentionunit

        hour_frequency = $_.snapshotSchedule.hour.basicschedule.frequency
        hour_retention = $_.snapshotSchedule.hour.basicschedule.retention
        hour_unit = $_.snapshotSchedule.hour.basicschedule.retentionunit

        daily_frequency = $_.snapshotSchedule.daily.basicschedule.frequency
        daily_retention = $_.snapshotSchedule.daily.basicschedule.retention
        daily_unit = $_.snapshotSchedule.daily.basicschedule.retentionunit

        weekly_frequency = $_.snapshotSchedule.weekly.basicschedule.frequency
        weekly_retention = $_.snapshotSchedule.weekly.basicschedule.retention
        weekly_unit = $_.snapshotSchedule.weekly.basicschedule.retentionunit
        weekly_day_of_week = $_.snapshotSchedule.weekly.basicschedule.dayofweek

        monthly_frequency = $_.snapshotSchedule.monthly.basicschedule.frequency
        monthly_retention = $_.snapshotSchedule.monthly.basicschedule.retention
        monthly_units = $_.snapshotSchedule.monthly.basicschedule.retentionunits
        monthly_day_of_month = $_.snapshotSchedule.monthly.dayofmonth

        quarterly_frequency = $_.snapshotSchedule.quarterly.basicschedule.frequency
        quarterly_retention = $_.snapshotSchedule.quarterly.basicschedule.retention
        quarterly_unit = $_.snapshotSchedule.quarterly.basicschedule.retentionunit
        quarterly_day_of_quarter = $_.snapshotSchedule.quarterly.dayofquarter
        quarterly_start_month = $_.snapshotSchedule.quarterly.quaterterstartmonth

        yearly_frequency = $_.snapshotSchedule.yearly.basicschedule.frequency
        yearly_retention = $_.snapshotSchedule.yearly.basicschedule.retention
        yearly_unit = $_.snapshotSchedule.yearly.basicschedule.retentionunit
        yearly_day_of_year = $_.snapshotSchedule.yearly.dayofyear
        yearly_year_start_month = $_.snapshotSchedule.yearly.yearstartmonth

        window_duration = $_.backupwindows.durationinhours
        window_hour = $_.backupwindows.startTimeAttributes.hour
        window_minute = $_.backupwindows.startTimeAttributes.minute

        first_full_duration = $_.firstfullbackupwindows.durationinhours
        first_full_hour = $_.firstfullbackupwindows.startTimeAttributes.hour
        first_full_minute = $_.firstfullbackupwindows.startTimeAttributes.minute
        first_full_day_of_week = $_.firstfullbackupwindows.startTimeAttributes.dayOfWeek.day

        replicationspecs_retentionDuration = $_.replicationspecsv2.retentionDuration.duration
        replicationspecs_retentionDuration_unit = $_.replicationspecsv2.retentionDuration.unit
    }

} | Export-CSV -Path "L:\Billy\PowerShell_scripts\Rubrik\Output\SLA\SLA-report.csv"


Get-RubrikDatabase -Hostname "acte-db864d" -Instance "mssqlserver" -Name "master"