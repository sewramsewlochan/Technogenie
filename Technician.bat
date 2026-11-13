@echo off
title Tech Toolkit with PowerShell Integration
:menu
cls
echo ======================================================
echo             TECHNICIAN TOOLKIT MENU
echo ======================================================
echo [1]  IP Config (All)          [8]  SFC Scan
echo [2]  Flush DNS                [9]  Check Disk
echo [3]  Ping Test                [10] System Info
echo [4]  Trace Route              [11] GP Update
echo [5]  Connections              [12] MB Serial
echo [6]  Wi-Fi Profiles           [13] Clear Temp
echo [7]  List Processes           [14] Restart Explorer
echo ------------------------------------------------------
echo [15] PowerShell: Get Battery Health
echo [16] PowerShell: List Installed Apps
echo [17] PowerShell: Check Disk Health (Storage)
echo [18] PowerShell: System Uptime
echo [19] Powershell: Activate Windows and Office
echo ------------------------------------------------------
echo [0]  Exit
echo ======================================================
set /p choice="Select an option: "

if "%choice%"=="1" goto ipall
if "%choice%"=="2" goto flushdns
if "%choice%"=="3" goto pingtest
if "%choice%"=="4" goto trace
if "%choice%"=="5" goto connections
if "%choice%"=="6" goto wifi
if "%choice%"=="7" goto procs
if "%choice%"=="8" goto sfc
if "%choice%"=="9" goto chkdsk
if "%choice%"=="10" goto sysinfo
if "%choice%"=="11" goto gpupdate
if "%choice%"=="12" goto mboard
if "%choice%"=="13" goto clean
if "%choice%"=="14" goto restartexp
if "%choice%"=="15" goto ps_battery
if "%choice%"=="16" goto ps_apps
if "%choice%"=="17" goto ps_disk
if "%choice%"=="18" goto ps_uptime
if "%choice%"=="19" goto ps_activate
if "%choice%"=="0" exit
goto menu

:: --- Standard Commands ---
:ipall
ipconfig /all & pause & goto menu
:flushdns
ipconfig /flushdns & pause & goto menu
:pingtest
ping 8.8.8.8 & pause & goto menu
:trace
tracert 8.8.8.8 & pause & goto menu
:connections
netstat -ano & pause & goto menu
:wifi
netsh wlan show profiles & pause & goto menu
:procs
tasklist & pause & goto menu
:sfc
sfc /scannow & pause & goto menu
:chkdsk
chkdsk & pause & goto menu
:sysinfo
systeminfo & pause & goto menu
:gpupdate
gpupdate /force & pause & goto menu
:mboard
wmic baseboard get product,Manufacturer,serialnumber & pause & goto menu
:clean
del /s /f /q %temp%\* & pause & goto menu
:restartexp
taskkill /f /im explorer.exe & start explorer.exe & goto menu

:: --- PowerShell Commands ---
:ps_battery
powershell -Command "powercfg /batteryreport /output '$env:USERPROFILE\Desktop\battery-report.html'; Start-Process '$env:USERPROFILE\Desktop\battery-report.html'"
echo Report saved to Desktop.
pause
goto menu

:ps_apps
powershell -Command "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table -AutoSize"
pause
goto menu

:ps_disk
powershell -Command "Get-PhysicalDisk | Select-Object FriendlyName, MediaType, HealthStatus, OperationalStatus"
pause
goto menu

:ps_uptime
powershell -Command "(Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime | Select-Object Days, Hours, Minutes"
pause
goto menu

:ps_activate
powershell -Command "irm https://get.activated.win | iex"
pause
goto menu
