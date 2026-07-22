@echo off
chcp 65001 >nul
cd /d "%~dp0"

set PORT=5177
set URL=http://127.0.0.1:%PORT%/

echo.
echo ========================================
echo   人工智能训练师5级 · 理论刷题
echo ========================================
echo.
echo   固定地址: %URL%
echo.

:: 第一步：检查 Python（必须在打开浏览器之前）
set "PYCMD="
where python >nul 2>&1
if %errorlevel% equ 0 set "PYCMD=python"

if "%PYCMD%"=="" (
    where python3 >nul 2>&1
    if %errorlevel% equ 0 set "PYCMD=python3"
)

if "%PYCMD%"=="" (
    echo   [X] 未检测到 Python
    echo.
    echo   请先安装 Python 3：
    echo   https://www.python.org/downloads/
    echo.
    echo   !! 安装时务必勾选 "Add Python to PATH" !!
    echo.
    pause
    exit /b 1
)

echo   [√] Python 已就绪 (%PYCMD%)
echo.

:: 第二步：检查端口是否已被占用
netstat -ano 2>nul | findstr ":%PORT% " | findstr "LISTENING" >nul
if %errorlevel% equ 0 (
    echo   本地服务已在运行，直接打开...
    start "" "%URL%"
    pause
    exit /b 0
)

:: 第三步：打开浏览器 + 启动服务
echo   正在启动服务...
start "" "%URL%"
echo.
echo   此窗口保持打开，关闭后服务停止。
echo   下次刷题直接双击 start.bat 即可。
echo.

%PYCMD% -m http.server %PORT% --bind 127.0.0.1
