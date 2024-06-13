##############################
## Usage
##############################
#
# Installing with Intune: Powershell.exe -windowstyle hidden -executionpolicy bypass -File Uninstall.ps1
#
#
##############################
## Variables
##############################

$location = "C:\Program Files\Spotify\Spotify.exe"
$winstart = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Spotify.lnk"

##############################
## Logging
##############################

$Logfile = "$env:temp\SpotifyUninstaller.log"

Function LogWrite {
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

if ((Test-Path $location) -and (test-path $winstart)) {
    LogWrite "Application found, removing..."
    Remove-Item "C:\Program Files\Spotify" -Recurse -Force
    Remove-item $winstart -Recurse -Force

}

if (!((Test-Path $location) -and (test-path $winstart))) {
    LogWrite "Application Successfully removed"
    Exit 0
}
else {
    LogWrite "Application not successfully removed"
    Exit 1
}