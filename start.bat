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
    echo   ═══════════════════════════════
    echo   Python 3 安装指引（小白版）
    echo   ═══════════════════════════════
    echo.
    echo   1. 打开浏览器，访问：
    echo      https://www.python.org/downloads/
    echo.
    echo   2. 点击黄色大按钮 「Download Python 3.x.x」
    echo      （会自动识别你的 Windows 系统）
    echo.
    echo   3. 下载完成后，双击打开安装包
    echo.
    echo   4. ⚠️ 重要！安装界面底部
    echo      务必勾选 ☑ 「Add Python to PATH」
    echo      （勾上之后那一行字前面会有个对钩）
    echo.
    echo   5. 点击 「Install Now」开始安装
    echo.
    echo   6. 安装完成后，重新双击 start.bat 即可
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
