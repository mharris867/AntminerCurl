$creds = Get-Credential # credentials are usually "root" user and "root" passowrd for Antminer
$loopforever = $true
While ($loopforever){
    if ((Invoke-RestMethod http://192.168.2.27/cgi-bin/get_miner_status.cgi -Credential $creds -AllowUnencryptedAuthentication).summary.ghs5s -lt 27){
        Invoke-RestMethod http://192.168.2.27/cgi-bin/reboot.cgi -Credential $creds -AllowUnencryptedAuthentication
        Write-Host "$(Get-Date) Restarted Antminer 27"
    }
    Write-Host "$(Get-Date) Sleeping for 15min"
    Start-Sleep -Seconds 900
}
