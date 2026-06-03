param(
    [string]$SettingsFile = "$PSScriptRoot/defaults.json",
    [string]$Key
)

$settings = (& $PSScriptRoot/_Load-Settings.ps1 -SettingsFile $SettingsFile)

# Define the JSON body for the login request using settings. Ignored for most API key access requests.
$claimTuples = @(
    @{type = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn"; value = $settings.UpnClaimValue },
    @{type = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"; value = $settings.NameClaimValue },
    @{type = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"; value = $settings.EMailClaimValue },
    @{type = "https://tempuri.org/askdelphi/editor2/fullname"; value = $settings.NameClaimValue },
    @{type = "https://tempuri.org/askdelphi/editor2/upn"; value = $settings.UpnClaimValue },
    @{type = "https://tempuri.org/askdelphi/editor2/email"; value = $settings.EMailClaimValue },
    @{type = "https://tempuri.org/askdelphi/editor2/tenant"; value = $settings.TenantGuid }
) | ConvertTo-Json

# Invoke the POST request for login
$response = Invoke-RestMethod -Uri "$($settings.ApiBaseURL)/v1/auth/key" -Method Post -Headers @{Authorization = "Bearer $($settings.AskDelphiAPIKey)" } -Body $claimTuples -ContentType "application/json"

# Write the response to auth.json in the script folder
$response | ConvertTo-Json -Depth 10 | Set-Content -Path "$PSScriptRoot/auth.json"

# Extract the token from the response
$response