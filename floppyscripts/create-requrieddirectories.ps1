if (!(get-item C:\temp -ErrorAction SilentlyContinue )) {
New-Item -Path C:\ -Name Temp -ItemType Directory
}

if (!(get-item C:\windows\setup\scripts -ErrorAction SilentlyContinue )) {
New-Item -Path C:\windows\setup\scripts -ItemType Directory
}
