param(
    [string]$SettingsFile = "$PSScriptRoot/defaults.json",
    [string]$Folder = "/",
    [string]$Query = $null
)
$settings = (& $PSScriptRoot/_Load-Settings.ps1 -SettingsFile $SettingsFile)
$auth = Get-Content -Raw -Path "$PSScriptRoot/auth.json" | ConvertFrom-Json

$body = @{
    "folderId" = $Folder
    "query" = $Query
    "topicTypes" = @()
 } | ConvertTo-Json

$foldersResponse = Invoke-RestMethod -Uri "$($settings.ApiBaseURL)/v1/tenant/$($settings.TenantGuid)/project/$($settings.ProjectGuid)/externaladapter/$($settings.ExternalAdapter)/contentfolders/search" -Method Post -Body $body -Headers @{Authorization = "Bearer $($auth.response.token)" } -ContentType "application/json"

$foldersResponse.response
