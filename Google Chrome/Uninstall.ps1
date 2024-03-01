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
# Uninstalling Google Chrome.
#
##############################
## Variables
##############################

$installationPath = (test-path "C:\Program Files\Google\Chrome\Application\chrome.exe")

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

# Checking if application is present: 
if ($installationpath) {
    Write-log "Application found.. Uninstalling..."
    $64bit = if ([System.IntPtr]::Size -eq 8) { $true } else { $false }
    $RegKeys = @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\')
    if ($true -eq $64bit) { $RegKeys += 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\' }
    $Apps = $RegKeys | Get-ChildItem | Get-ItemProperty | Where-Object { $_.DisplayName -like '*Chrome*' }

    $Apps | ForEach-Object {
        $ExecLocation = "$($_.UninstallString.Split('"')[1])"
        Start-Process -FilePath "$ExecLocation" -ArgumentList "--uninstall --system-level --force-uninstall" -Wait
    }    
}

