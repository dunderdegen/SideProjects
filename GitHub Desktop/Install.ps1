#######################################################
#    ____ _ _   _           _           
#   / ___(_) |_| |__  _   _| |__        
#   | |  _| | __| '_ \| | | | '_ \       
#   | |_| | | |_| | | | |_| | |_) |      
#   \____|_|\__|_| |_|\__,_|_.__/       
#    ____            _    _              
#   |  _ \  ___  ___| | _| |_ ___  _ __  
#   | | | |/ _ \/ __| |/ / __/ _ \| '_ \ 
#   | |_| |  __/\__ \   <| || (_) | |_) |
#   |____/ \___||___/_|\_\\__\___/| .__/ 
#                                 |_|    
#############################
## Usage
##############################
#
# Installing with Intune: Powershell.exe -windowstyle hidden -executionpolicy bypass -File Install.ps1
# Run in user context for \appdata detection. 
#
##############################
## Variables
##############################

$appName = "GitHub Desktop"

$url = "https://central.github.com/deployments/desktop/desktop/latest/win32?format=msi"
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
Start-Sleep -Seconds 10
&"C:\Program Files (x86)\GitHub Desktop Deployment\GitHubDesktopDeploymentTool.exe"

# Removing temporary folder
Remove-Item -Path $dest -Recurse -Force

If (test-path "${env:LOCALAPPDATA}\GitHubDesktop\Githubdesktop.exe"){
    LogWrite "Application installed. Exiting."
    Exit 0
}
Exit 1



