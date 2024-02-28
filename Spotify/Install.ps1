##############################
## Usage
##############################
#
# Installing with Intune: Powershell.exe -windowstyle hidden -executionpolicy bypass -File Install.ps1
#
#
##############################
## Variables
##############################

$url = "https://download.spotify.com/SpotifyFullSetup.exe"
$dest = "C:\Temp\Spotify"

$winstart = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Spotify.lnk"

##############################
## Logging
##############################

$Logfile = "$env:temp\SpotifyInstaller.log"

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

# Creating directory where spotify lands after download
if (!(test-path $dest)){
    LogWrite "Downloading destination not found, creating.."
    mkdir $dest -Force
}
else {LogWrite "Downloading destination found. Continuing.."}

LogWrite "Starting Download"
# Downloading Zipped installer
Start-BitsTransfer -Source $url -Destination $dest
LogWrite "Download completed. Extracting files to C:\Program Files\Spotify"
# Extracting to C:\Program Files
&$dest\SpotifyFullSetup.exe /extract "C:\Program Files\Spotify"

LogWrite "Files Extracted.Creating Shortcut"
#Creating Shortcut
$TargetFile = "C:\Program Files\Spotify\Spotify.exe"
$ShortcutFile = $winstart
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()

# Removing temporary folder
Remove-Item -Path "C:\Temp\Spotify" -Recurse -Force

If (test-path $winstart){
    LogWrite "Shortcut created in Start meny. Exiting."
    Exit 0
}
Exit 1

