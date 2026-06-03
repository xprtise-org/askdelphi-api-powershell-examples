param(
    [string]$SettingsFile = "$PSScriptRoot/defaults.json"
)
$settings = (& $PSScriptRoot/_Load-Settings.ps1 -SettingsFile $SettingsFile)
$auth = Get-Content -Raw -Path "$PSScriptRoot/auth.json" | ConvertFrom-Json

$response1 = Invoke-RestMethod -Uri "$($settings.ApiBaseURL)/v1/release/releaseBranch" -Method Get -Headers @{Authorization = "Bearer $($auth.response.token)" } -ContentType "application/json"
$response2 = Invoke-RestMethod -Uri "$($settings.ApiBaseURL)/v1/release/buildNumber" -Method Get -Headers @{Authorization = "Bearer $($auth.response.token)" } -ContentType "application/json"

@{ ReleaseBranch = $response1.response.releaseBranch; BuildNumber = $response2.response.buildNumber }

