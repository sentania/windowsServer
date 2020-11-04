set PS64=%SystemRoot%\syswow64\WindowsPowerShell\v1.0\powershell.exe
set PS32=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
if exist %PS64% (
set PS=%PS64%
) else (
set PS=%PS32%
)

echo %PS%

REM Call the SetupComplete.ps1 script, to begin configuring the server
md C:\temp
echo [%date% %time%] Setupcomplete.cmd starting... > C:\temp\lab-setup.log
echo [%date% %time%] Calling setupcomplete.ps1 >> C:\temp\lab-setup.log
%PS% set-executionpolicy unrestricted

start %PS% %windir%\setup\scripts\setupcomplete.ps1
