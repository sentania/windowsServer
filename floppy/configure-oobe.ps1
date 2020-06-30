#This script is called during the OOBE experience pass of the windows install
#It will execute all .ps1 files in the A:\scripts directory.
#Scripts in this directory should be fully autonomous and have no dependencies on other scripts
#optimally each script should perform a single task (we're talking art vs. science here)
#In reality much of the tasks performed by these scripts could be embedded in teh unattended file, but that makes it harder to maintain/follow


#This script also has the important job of setting WinRM to disabled at the beginning

Get-ChildItem 'A:\floppyscripts\*.ps1' | ForEach-Object {
  & $_.FullName
}
$ErrorActionPreference = "Stop"

# Switch network connection to private mode
# Required for WinRM firewall rules
$profile = Get-NetConnectionProfile
Set-NetConnectionProfile -Name $profile.Name -NetworkCategory Private

# Enable WinRM service
winrm quickconfig -quiet
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

# Reset auto logon count
# https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup-autologon-logoncount#logoncount-known-issue
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonCount -Value 0