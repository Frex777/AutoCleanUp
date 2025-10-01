@echo off
color 0A

net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo [AutoCleanUp]: Running with administrator privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb runAs"
    exit /b
)

echo [AutoCleanUp]: Cleaning temporary folders...

del /s /f /q "%TEMP%\*" 2>nul
del /s /f /q "%SystemRoot%\Temp\*" 2>nul
del /s /f /q "%LOCALAPPDATA%\Temp\*" 2>nul

del /s /f /q "%SystemRoot%\Prefetch\*" 2>nul

del /s /f /q "%SystemRoot%\SoftwareDistribution\Download\*" 2>nul

del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\WER\ReportQueue\*" 2>nul
del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\WER\Temp\*" 2>nul

:: ========================================================

echo [AutoCleanUp]: Cleaning Windows Update leftovers...
del /s /f /q "%SystemRoot%\SoftwareDistribution\Datastore\*" 2>nul
del /s /f /q "%SystemRoot%\SoftwareDistribution\DeliveryOptimization\*" 2>nul

echo [AutoCleanUp]: Cleaning Windows logs...
wevtutil cl Application
wevtutil cl Security

echo [AutoCleanUp]: Removing old drivers...
pnputil /d e /f

echo [AutoCleanUp]: Disabling and removing hibernation file...
powercfg -h off

echo [AutoCleanUp]: Cleanup completed.

exit

:: ========================================================
:: AUTHOR: frex777
:: ========================================================

