#######################################################
#
#    $$$$$$\  $$\                                                   
#   $$  __$$\ $$ |                                                  
#   $$ /  \__|$$$$$$$\   $$$$$$\   $$$$$$\  $$$$$$\$$$$\   $$$$$$\  
#   $$ |      $$  __$$\ $$  __$$\ $$  __$$\ $$  _$$  _$$\ $$  __$$\ 
#   $$ |      $$ |  $$ |$$ |  \__|$$ /  $$ |$$ / $$ / $$ |$$$$$$$$ |
#   $$ |  $$\ $$ |  $$ |$$ |      $$ |  $$ |$$ | $$ | $$ |$$   ____|
#   \$$$$$$  |$$ |  $$ |$$ |      \$$$$$$  |$$ | $$ | $$ |\$$$$$$$\ 
#    \______/ \__|  \__|\__|       \______/ \__| \__| \__| \_______|
#                                                                                                                                  
#############################
## Usage
##############################
#
# Installing with Intune: Powershell.exe -windowstyle hidden -executionpolicy bypass -File Install.ps1
#
##############################
## Variables
##############################

$appName = "Google Chrome"

$url = "https://dl.google.com/chrome/install/googlechromestandaloneenterprise64.msi"
$dest = "C:\Temp\${appName}"

##############################
## Logging
##############################

$Logfile = "$env:temp\${appName}Installer.log"

Function Write-log {
    Param ([string]$logstring)
    $a = Get-Date
    $logstring = $a, $logstring
    Try {
        Add-content $Logfile -value $logstring  -ErrorAction silentlycontinue
    }
    Catch {
        $logstring = "Invalid data encountered"
        Add-content $Logfile -value $logstring
    }
    write-host $logstring
}

##############################
## Start script
##############################

# Creating directory where spotify lands after download
if (!(test-path $dest)){
    Write-log "Downloading destination not found, creating.."
    mkdir $dest -Force
}
else {Write-log "Downloading destination found. Continuing.."}

Write-log "Starting Download"

# Downloading MSI package
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -OutFile "${dest}\${appName}.msi"
Write-log "Download completed. Installation file resides at: ${dest}"

# Installing MSI Package
$fileName = Get-ChildItem -Path $dest
msiexec.exe /i "${dest}\$fileName" /qn

# Removing temporary folder
Remove-Item -Path $dest -Recurse -Force

If (test-path "C:\Program Files\Google\Chrome\Application\chrome.exe"){
    LogWrite "Application installed. Exiting."
    Exit 0
}
Exit 1
