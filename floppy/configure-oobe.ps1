#This script is called during the OOBE experience pass of the windows install
#It will execute all .ps1 files in the A:\scripts directory.
#Scripts in this directory should be fully autonomous and have no dependencies on other scripts
#optimally each script should perform a single task (we're talking art vs. science here)
#In reality much of the tasks performed by these scripts could be embedded in teh unattended file, but that makes it harder to maintain/follow


#This script also has the important job of setting WinRM to disabled at the beginning

netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new enable=yes action=block
netsh advfirewall firewall set rule group="Windows Remote Management" new enable=yes
$winrmService = Get-Service -Name WinRM
if ($winrmService.Status -eq "Running"){
    Disable-PSRemoting -Force
}
Stop-Service winrm
Set-Service -Name winrm -StartupType Disabled



Get-ChildItem 'A:\floppyscripts\*.ps1' | ForEach-Object {
  & $_.FullName
}
