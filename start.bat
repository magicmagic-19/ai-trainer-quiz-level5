@echo off
title AI Trainer Level 5 - Quiz
cd /d "%~dp0"

set PORT=5177
set URL=http://127.0.0.1:5177/

:: Check Python
python --version >nul 2>&1
if not errorlevel 1 goto :found
python3 --version >nul 2>&1
if not errorlevel 1 goto :found3

:: ========== Python NOT found ==========
echo.
echo ********************************************
echo   AI Trainer Level 5 - Practice Quiz
echo ********************************************
echo.
echo   [X] Python 3 is NOT installed!
echo.
echo   Please install Python 3 first:
echo.
echo   Step 1: Open this link in your browser
echo           https://www.python.org/downloads/
echo.
echo   Step 2: Click the big yellow download button
echo           and run the installer.
echo.
echo   Step 3: [IMPORTANT!]
echo           Check the box "Add Python to PATH"
echo           at the bottom of the installer window.
echo.
echo   Step 4: Click "Install Now" and wait.
echo.
echo   Step 5: Double-click start.bat again when done.
echo.
echo ********************************************
pause
exit

:: ========== Python found ==========
:found3
set PYCMD=python3
goto :start

:found
set PYCMD=python

:start
echo.
echo ********************************************
echo   AI Trainer Level 5 - Practice Quiz
echo ********************************************
echo.
echo   [OK] Python 3 is ready.
echo.
echo   Starting server, browser will open shortly...
echo.
echo   >> Keep this window open while studying. <<
echo   >> Double-click start.bat to start again. <<
echo.
echo ********************************************
echo.

start "" "%URL%"
%PYCMD% -m http.server %PORT% --bind 127.0.0.1
pause
