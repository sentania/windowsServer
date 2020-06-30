Param(
  [string]$vSphereUSERNAME,
  [string]$vSpherePASSWORD,
  [string]$sourceVM
)

Connect-VIServer -Server vcenter.int.sentania.net -User $vSphereUSERNAME -Password $vSpherePASSWORD

$sourceVMobj = get-vm -Name $sourceVM

Export-VM -Destination C:\temp\ -Format Ova -VM $sourceVMobj

$contentlibraryitem = @{
    ContentLibrary = Get-ContentLibrary -name "sentania.net"
    File = get-item -path "/tmp/packertest.ova"
    name = "packertest"
}
New-ContentLibraryItem @contentlibraryitem