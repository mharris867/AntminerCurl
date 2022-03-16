$creds = Get-Credential # credentials are usually "root" user and "root" password for Antminer
$antminerIP = Read-Host -Prompt "Press enter to accept the default 192.168.2.27"
if ([string]::IsNullOrWhiteSpace($antminerIP)) { $antminerIP = "192.168.2.27" }
$loopforever = $true
While ($loopforever) {
    if ((Invoke-RestMethod http://$antminerIP/cgi-bin/get_miner_status.cgi -Credential $creds -AllowUnencryptedAuthentication).summary.ghs5s -lt 27) {
        Invoke-RestMethod http://$antminerIP/cgi-bin/reboot.cgi -Credential $creds -AllowUnencryptedAuthentication
        Write-Host "$(Get-Date) Restarted Antminer 27" -ForegroundColor DarkRed 
    }
    Write-Host "$(Get-Date) Sleeping for 15min" -ForegroundColor DarkGreen 
    Start-Sleep -Seconds 900
}
