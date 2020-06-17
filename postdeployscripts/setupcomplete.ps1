#this script configures WinRM for post deployment access by ansible.
#It disables the non-SSL access used by packer during image generation
#it uses a self signed cert - ideally this would be replaced by a A

$myhostname = hostname
$thumbprint = (New-SelfSignedCertificate -DnsName $myhostname -CertStoreLocation Cert:\LocalMachine\My).thumbprint

$SubjectName = $myhostname

    # Create the hashtables of settings to be used.
    $valueset = @{
        Hostname = $SubjectName
        CertificateThumbprint = $thumbprint
    }

    $selectorset = @{
        Transport = "HTTPS"
        Address = "*"
    }

 
New-WSManInstance -ResourceURI 'winrm/config/Listener' -SelectorSet $selectorset -ValueSet $valueset

winrm set winrm/config/service '@{AllowUnencrypted="false"}'
winrm set winrm/config/service/auth '@{Basic="false"}'

$httpResult = Invoke-Command -ComputerName "localhost" -ScriptBlock {$env:COMPUTERNAME} -ErrorVariable httpError -ErrorAction SilentlyContinue
$httpsOptions = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck

$httpsResult = New-PSSession -UseSSL -ComputerName "localhost" -SessionOption $httpsOptions -ErrorVariable httpsError -ErrorAction SilentlyContinue

if ($httpResult)
{
    Write-host "http acess wasn't disabled"
}

if (!($httpsResult))
{
    write-host "https access wasn't enabled"
}