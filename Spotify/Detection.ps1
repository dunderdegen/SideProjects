##############################
## Variables
##############################

$location = "C:\Program Files\Spotify\Spotify.exe"
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

if ((test-path $location) -and (test-path $winstart)){
    LogWrite "Application found. Installation successfull."
    exit 0
}
else {
    LogWrite "Application not found. Installation not successfull."
    Exit 1
}