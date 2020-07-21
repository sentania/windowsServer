﻿Param(
  [string]$vSphereUSERNAME,
  [string]$vSpherePASSWORD,
  [string]$sourceVM
)

Connect-VIServer -Server vcenter.int.sentania.net -User $vSphereUSERNAME -Password $vSpherePASSWORD

$sourceVMobj = get-vm -Name $sourceVM

Export-VM -Destination /tmp/ -Format Ova -VM $sourceVMobj -Name server2019

$contentlibraryitem = @{
    ContentLibrary = Get-ContentLibrary -name "vcenter.int.sentania.net"
    File = get-item -path "/tmp/server2019.ova"
    name = "server2019"
}
New-ContentLibraryItem @contentlibraryitem
Remove-Item /tmp/server2019.ova -Confirm:$false
#simple update.