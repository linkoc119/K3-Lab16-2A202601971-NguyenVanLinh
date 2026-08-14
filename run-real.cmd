@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0run-real.ps1" %*
exit /b %ERRORLEVEL%
