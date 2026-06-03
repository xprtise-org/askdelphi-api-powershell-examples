param(    
    [string]$SettingsFile
)

$settings = Get-Content -Raw -Path $SettingsFile | ConvertFrom-Json

$settings