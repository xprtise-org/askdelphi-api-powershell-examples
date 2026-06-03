param(
    [string]$SettingsFile = "$PSScriptRoot/defaults.json",
    [string]$ContentShareId
)
$settings = (& $PSScriptRoot/_Load-Settings.ps1 -SettingsFile $SettingsFile)
$auth = Get-Content -Raw -Path "$PSScriptRoot/auth.json" | ConvertFrom-Json


$response = Invoke-RestMethod -Uri "$($settings.ApiBaseURL)/v1/tenant/$($settings.TenantGuid)/project/$($settings.ProjectGuid)/acl/$($settings.AclGuid)/share/$ContentShareId/snapshot" -Method Get -Headers @{Authorization = "Bearer $($auth.response.token)" } -ContentType "application/json"

$response.response
