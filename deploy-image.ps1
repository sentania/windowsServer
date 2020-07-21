Param(
  [string]$vSphereUSERNAME,
  [string]$vSpherePASSWORD,
  [string]$sourceVM
)

Connect-VIServer -Server vcenter.int.sentania.net -User $vSphereUSERNAME -Password $vSpherePASSWORD

$sourceVMobj = get-vm -Name $sourceVM

Export-VM -Destination /tmp/ -Format Ova -VM $sourceVMobj -Name server2019
