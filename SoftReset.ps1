$creds = Get-Credential # credentials are usually "root" user and "root" password for Antminer
$antminerIP = Read-Host -Prompt "Press enter to accept the default Antminer IP 192.168.2.27" # Prompt for Antminer IP
if ([string]::IsNullOrWhiteSpace($antminerIP)) { $antminerIP = "192.168.2.27" } # Set Antminer IP to default if not input from user
$loopforever = $true
While ($loopforever) {
    # Starting with a Ksols/S(RT) setting of 27 Ksols in the line below to trigger a restart. This might need tweeking. 
    # Thinking about using http://@antminerIP/cgi-bin/get_miner_conf.cgi to find the bitmain-freq and increase or reduce the Ksols threshold if necessary
    if ((Invoke-RestMethod http://$antminerIP/cgi-bin/get_miner_status.cgi -Credential $creds -AllowUnencryptedAuthentication).summary.ghs5s -lt 32) {
        Invoke-RestMethod http://$antminerIP/cgi-bin/reboot.cgi -Credential $creds -AllowUnencryptedAuthentication
        Write-Host "$(Get-Date) Restarted Antminer 27" -ForegroundColor DarkRed 
    }
    Write-Host "$(Get-Date) Sleeping for 15min" -ForegroundColor DarkGreen 
    Start-Sleep -Seconds 900
}