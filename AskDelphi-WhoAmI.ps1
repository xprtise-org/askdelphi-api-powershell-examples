param(
    [string]$SettingsFile = "$PSScriptRoot/defaults.json"
)

try {
    $response = (& $PSScriptRoot/AskDelphi-Authenticate-WithAPIKey.ps1 -SettingsFile $SettingsFile)
    $jwt = $response.response.token
    $p = $jwt.Split('.')[1].Replace('-', '+').Replace('_', '/'); [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($p.PadRight($p.Length + (4 - $p.Length % 4) % 4, '='))) | ConvertFrom-Json
}
catch {
    Write-Error "Failed to authenticate: $_"
}
