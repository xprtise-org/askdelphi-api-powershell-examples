param(
    [string]$SettingsFile = "$PSScriptRoot/defaults.json",
    [string]$Folder = "/"
)
$settings = (& $PSScriptRoot/_Load-Settings.ps1 -SettingsFile $SettingsFile)
$auth = Get-Content -Raw -Path "$PSScriptRoot/auth.json" | ConvertFrom-Json

$body = @{
    "folderId" = $Folder
 } | ConvertTo-Json

$foldersResponse = Invoke-RestMethod -Uri "$($settings.ApiBaseURL)/v1/tenant/$($settings.TenantGuid)/project/$($settings.ProjectGuid)/externaladapter/$($settings.ExternalAdapter)/contentfolders" -Method Post -Body $body -Headers @{Authorization = "Bearer $($auth.response.token)" } -ContentType "application/json"

$foldersResponse.response.data
