param(
    [string]$SettingsFile = "$PSScriptRoot/defaults.json",
    [string]$Query = $null
)
$settings = (& $PSScriptRoot/_Load-Settings.ps1 -SettingsFile $SettingsFile)
$auth = Get-Content -Raw -Path "$PSScriptRoot/auth.json" | ConvertFrom-Json

$body = @{
    "query" = $Query
    "topicTypes" = @()
    "namespaces" = @()
    "page" = 1
    "pageSize" = 100
 } | ConvertTo-Json

$topicListResponse = Invoke-RestMethod -Uri "$($settings.ApiBaseURL)/v1/tenant/$($settings.TenantGuid)/project/$($settings.ProjectGuid)/acl/$($settings.AclGuid)/checkedouttopiclist" -Method Post -Body $body -Headers @{Authorization = "Bearer $($auth.response.token)" } -ContentType "application/json"

$topicListResponse.response
