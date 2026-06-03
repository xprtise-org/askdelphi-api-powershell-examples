param(
    [string]$SettingsFile = "$PSScriptRoot/defaults.json",
    [string]$ContentShareId,
    [string]$Title
)
$settings = (& $PSScriptRoot/_Load-Settings.ps1 -SettingsFile $SettingsFile)
$auth = Get-Content -Raw -Path "$PSScriptRoot/auth.json" | ConvertFrom-Json

$body = @{
    "title" = $Title
} | ConvertTo-Json
$response = Invoke-RestMethod -Uri "$($settings.ApiBaseURL)/v1/tenant/$($settings.TenantGuid)/project/$($settings.ProjectGuid)/acl/$($settings.AclGuid)/share/$ContentShareId/snapshot" -Method Post -Body $body -Headers @{Authorization = "Bearer $($auth.response.token)" } -ContentType "application/json"

$response.response
