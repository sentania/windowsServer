$targetdir = "$env:WINDIR\setup\scripts\"

#make sure the scripts directory exists
if (!(get-item $targetdir))
{
    New-Item -Path $targetdir -ItemType Directory
}
Copy-Item A:\postdeployscripts\* -Destination $targetdir