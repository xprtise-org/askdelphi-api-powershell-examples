# AskDelphi API Access PowerShell Scripts

This project contains PowerShell scripts that allows accessing the AskDelphi API to perform various tasks.
The scripts are intended to demonstrate how to access the AskDelphi API. These are not intended to be used
in production environments.

## Getting started

Before you can use these scripts, you need to create a JSON file containing the details about your
project, ACL, tenant and (if using API keys) the access key.

The file should be structured like this:

```JSON
{
    "AskDelphiAPIKey": "ApiKeyName1:apikeyvalueasprovided",
    "TenantGuid": "505980ff-e834-4277-8e70-6953b263b06f",
    "ProjectGuid": "b4d3f692-10c0-4a5e-b5ad-eb965611c163",
    "AclGuid": "32bd04d3-94bc-4e98-8fa5-d3e2b61a53de",

    "ExternalAdapter": "null",

    "ApiBaseURL": "https://edit.api.askdelphi.com"
}
```

If you write this to ```defaults.json``` then all scripts will use this for all operations, otherwise
pass the path to the file to these scripts with the ```-SettingsFile``` parameter.

Test uour settings file using the script ```AskDelphi-WhoAmI.ps1 -SettingsFile .\my-access-details.json```

The output should be the list of claim values that are registered for your API key.

## Before issuing a command...

You need to authenticate. These scripts support API key authentication only. When using a session
code ou can use the other code samples that are shared on the XPrtise GitHub.

Run ```AskDelphi-Authenticate-WithAPIKey.ps1  -SettingsFile .\my-access-details.json```. This will
authenticate the current session and will create a file called ```auth.json``` that contains your current
access token. This is a short-lived token that can't be refreshed. Instead when the token expires
a new authentication action should be run.

## Run one of the API access sample scripts

You can use any one of the example API calls as a starting point for developing your own API access.
For example, you can use ```AskDelphi-GetTopicList.ps1 -SettingsFile .\my-access-details.json``` 
after authenticating to request the topic list for the project. 

### Examples for API Key authentication
- AskDelphi-Authenticate-WithAPIKey.ps1

### Example for service information
- AskDelphi-GetAPIVersion.ps1

### Examples for getting user details and access rights
- AskDelphi-UserGetUserACLs.ps1
- AskDelphi-UserGetUserEditingACLs.ps1
- AskDelphi-UserGetUserInfo.ps1
- AskDelphi-WhoAmI.ps1

### Examples for accessing project-level information
- AskDelphi-GetTopicList.ps1
- AskDelphi-ProjectFindCheckedOutTopics.ps1
- AskDelphi-TenantGetPublications.ps1

### Examples for accessing tenant-level information
- AskDelphi-TenantGetProjects.ps1
- AskDelphi-TenantGetTenantInfo.ps1

### Examples for interacting with content provided by external content-adapters
- AskDelphi-TenantGetAdapters.ps1
- AskDelphi-AdapterFindTopics.ps1
- AskDelphi-AdapterListContentFolders.ps1

### Examples for working with shared project snapshots
- AskDelphi-ContentShareCreateSnapshot.ps1
- AskDelphi-ContentShareDeleteSnapshot.ps1
- AskDelphi-ContentShareGetSnapshotDetails.ps1
- AskDelphi-ContentShareGetSnapshots.ps1





