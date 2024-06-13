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
# Detecting if Google Chrome is installed.
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
if ($installationpath){
    Write-log "Application Installed. Exiting with sucess. "
    Exit 0
}
Write-log "Application not found.. "
Exit 1
