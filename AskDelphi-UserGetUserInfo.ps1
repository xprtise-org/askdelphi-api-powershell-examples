param(
    [string]$SettingsFile = "$PSScriptRoot/defaults.json"
)
$settings = (& $PSScriptRoot/_Load-Settings.ps1 -SettingsFile $SettingsFile)
$auth = Get-Content -Raw -Path "$PSScriptRoot/auth.json" | ConvertFrom-Json

$response = @{}
$response = Invoke-RestMethod -Uri "$($settings.ApiBaseURL)/v1/tenant/$($settings.TenantGuid)/user/getuser" -Method Get -Headers @{Authorization = "Bearer $($auth.response.token)" } -ContentType "application/json"
$response.response
