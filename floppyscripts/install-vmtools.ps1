$ProgressPreference = "SilentlyContinue"
$package = "VMware-tools-11.2.6-17901274-x86_64.exe"
$version = "11.2.6"
$url = "https://packages.vmware.com/tools/releases/$version/windows/x64/$package"
$exe = "$Env:TEMP\$package"
Write-Output "***** Downloading VMware Tools"
Write-Output "***** Download URL: $url"

Write-Output "***** Downloading VMware Tools"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $exe)

$parameters = '/S /v "/qn REBOOT=R ADDLOCAL=ALL"'

Write-Output "***** Installing VMware Tools"
Start-Process $exe $parameters -Wait

Write-Output "***** Deleting $exe"
Remove-Item $exe

