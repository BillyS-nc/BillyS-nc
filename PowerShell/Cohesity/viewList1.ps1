### process commandline arguments
[CmdletBinding()]
param (
    [Parameter(Mandatory = $True)][string]$vip,
    [Parameter(Mandatory = $True)][string]$username,
    [Parameter()][string]$domain = 'local'
)

### source the cohesity-api helper code
. $(Join-Path -Path $PSScriptRoot -ChildPath cohesity-api.ps1)

### authenticate
apiauth -vip sbch-dp01br -username api-test -domain $domain

$ignore = @('madrox:', 'magneto_', 'icebox_', 'AUDIT_', 'yoda_', 'cohesity_download_', 'COHESITY_HELIOS_')

$views = api get "views?_includeTenantInfo=true&allUnderHierarchy=true&includeInternalViews=true"
foreach ($view in $views.views){
        $logicalGB = $view.logicalUsageBytes/(1024*1024*1024)
        "    View Name: $($view.name)"
        "  Description: $($view.description)"
        "Logical Bytes GB: $($view.logicalUsageBytes/(1024*1024*1024))"
        "      Created: $(usecsToDate ($view.createTimeMsecs * 1000))"
        "    Whitelist:"
        "-------"
     }


