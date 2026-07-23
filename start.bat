@echo off
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0start.ps1"
if %errorlevel% neq 0 (
    echo PowerShell not available, trying cmd fallback...
    goto :cmd_fallback
)
exit

:cmd_fallback
:: Fallback if PowerShell is unavailable (rare on Win 10/11)
set PORT=5177
set URL=http://127.0.0.1:5177/

python --version >nul 2>&1
if not errorlevel 1 goto :f_found
python3 --version >nul 2>&1
if not errorlevel 1 goto :f_found3

echo [X] Python 3 NOT found. Install from https://www.python.org/downloads/
pause
exit

:f_found3
set PYCMD=python3
goto :f_start
:f_found
set PYCMD=python

:f_start
echo [OK] Python 3 ready. Starting server...
start "" "%PYCMD%" -m http.server %PORT% --bind 127.0.0.1
timeout /t 1 /nobreak >nul
start "" "%URL%"
pause
