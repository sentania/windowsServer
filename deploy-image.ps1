Param(
  [string]$vSphereUSERNAME,
  [string]$vSpherePASSWORD,
  [string]$sourceVM
)

Connect-VIServer -Server vcenter.int.sentania.net -User $vSphereUSERNAME -Password $vSpherePASSWORD

$sourceVMobj = get-vm -Name $sourceVM

Export-VM -Destination /tmp/ -Format Ova -VM $sourceVMobj -Name server2019.ova

$contentlibraryitem = @{
    ContentLibrary = Get-ContentLibrary -name "sentania.net"
    File = get-item -path "/tmp/server2019.ova"
    name = "packertest"
}
New-ContentLibraryItem @contentlibraryitem
Remove-Item /tmp/server2019.ova -Confirm:$false
#simple update.