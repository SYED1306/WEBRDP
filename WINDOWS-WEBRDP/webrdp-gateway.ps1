$url ='https://cheekandchongsupinthesmoke-my.sharepoint.com/personal/bulletformyvalentine_cheekandchongsupinthesmoke_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=1c26147351cd348b69f27368585199ec1&authkey=AaNUvYIi7g7cPrlnc2s7Gz4'
$codeSetupUrl = Get-RedirectedUrl -URL $url
$PSScriptRoot="https://github.com/SYED1306/WEBRDP/tree/master/WINDOWS-WEBRDPhttps://github.com/SYED1306/WEBRDP/tree/master/WINDOWS-WEBRDP"

$infPath = $PSScriptRoot + "\webrdpgateway.inf"
$wrdpcodeSetup = "${env:Temp}\webRDP-Gateway_1.2.0.43-Win-64.exe"

Function Get-RedirectedUrl
{
    Param (
        [Parameter(Mandatory=$true)]
        [String]$URL
    )
 
    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()
 
    If ($response.StatusCode -eq "Found")
    {
        $response.GetResponseHeader("Location")
    }
}


try
{
    (New-Object System.Net.WebClient).DownloadFile($codeSetupUrl, $wrdpcodeSetup)
}
catch
{
    Write-Error "Failed to download webrdp-gateway Setup"
}

try
{
    Start-Process -FilePath $wrdpcodeSetup -ArgumentList "/VERYSILENT /MERGETASKS=!runcode /LOADINF=$infPath"
}
catch
{
    Write-Error 'webrdp-gateway'
}