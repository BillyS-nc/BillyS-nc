# SMB server to connect to:
$Cohesity = 'sbch-dp01br.sigi.us.selective.com'

# Shares that match this regex will be processed for file deletion:
$ShareRegex = '^SQL_(PROD|TEST)_.+?_[A-Z]{2}\d{5}$'

# Write logs here (the directory will be auto-groomed):
$LogDir = "$PSScriptRoot\Logs\10D"

# Syslog settings (Log Insight):
$SyslogSettings = @{
    AppName = 'SIGI_FileCleanup'
    ProcId = 'CohesitySqlViews_{0}' -f (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
    #PassThru = $true # Uncomment to send output to console (will be a firehose of events)
    #Server = 'localhost' # Uncomment to disable syslog output
}


# Load necessary modules
Import-Module $PSScriptRoot\Send-SigiSyslog.psm1 -Force -ErrorAction Stop
Import-Module $PSScriptRoot\Sigi.FileCleanup.psm1 -Force -ErrorAction Stop

# Create the logging directory if it doesn't exist yet (does nothing if it already exists)
$null = mkdir $LogDir -Force

# Run the cleanup, and direct all output streams to syslog.
try {
    & {
        # Get a list of full share paths
        $shares = Get-SigiNetViewShare -ComputerName $Cohesity -ShareRegex $ShareRegex
        foreach ($share in $shares) {
            $auditLogFile = "$LogDir\{0}.{1}.audit.log" -f [DateTime]::Now.ToString('yyyy-MM-dd_HHmmss'), [System.IO.Path]::GetFileName($share)
            try {
                Remove-SigiFilesByFolderPolicy -Path $share -Recurse -PerDirectoryMetrics -PolicyRedeclarationWarning -AuditLogFile $auditLogFile -IndividualFileDeletionInformation
            } catch {
                Write-Error -ErrorAction Continue "Failed to process '$share': $_"
            }
        }
    } *>&1 | ForEach-Object { $_ | Format-List | Out-String } | Send-SigiSyslog @SyslogSettings
} catch {
    $_ | Send-SigiSyslog @SyslogSettings -Severity Critical
}

# Remove old logs
Remove-SigiFilesByFolderPolicy -Path $LogDir -Recurse
