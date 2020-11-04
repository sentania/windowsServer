#disable hibernation
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\Power" -Name HibernateFileSizePercent -Value 0
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\Power" -Name HibernateEnabled -Value 0

#clear the paging file at shutdown
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -name ClearPageFileAtShutdown -value 1