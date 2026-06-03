param(
    [string]$SettingsFile = "$PSScriptRoot/defaults.json"
)
$settings = (& $PSScriptRoot/_Load-Settings.ps1 -SettingsFile $SettingsFile)
$auth = Get-Content -Raw -Path "$PSScriptRoot/auth.json" | ConvertFrom-Json

$bodyObj = @{
    orderBy = "lastModificationDate"
    isSortAsc = $null
    excludeSharedContent =$null
    page = 1
    pageSize = 50
    onlyEditable = $null
    topicTypes = $null
}

$body = $bodyObj | ConvertTo-Json
$response = Invoke-RestMethod `
    -Uri "$($settings.ApiBaseURL)/v1/tenant/$($settings.TenantGuid)/project/$($settings.ProjectGuid)/acl/$($settings.AclGuid)/topiclist" `
    -Method Post `
    -Body $body `
    -Headers @{Authorization = "Bearer $($auth.response.token)" } `
    -ContentType "application/json"

$response.response
