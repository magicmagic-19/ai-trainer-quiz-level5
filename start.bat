@echo off
title 人工智能训练师5级刷题
cd /d "%~dp0"

set PORT=5177
set URL=http://127.0.0.1:5177/

:: 检测 Python3（直接用 python/python3 命令试，不依赖 where）
python --version >nul 2>&1
if not errorlevel 1 goto :found_python

python3 --version >nul 2>&1
if not errorlevel 1 goto :found_python3

:: ========== 没找到 Python ==========
echo.
echo ========================================
echo   人工智能训练师5级 · 理论刷题
echo ========================================
echo.
echo   [X] 未检测到 Python
echo.
echo   ---------- 安装指引（小白版）----------
echo.
echo   1. 打开浏览器，访问下面这个网址：
echo      https://www.python.org/downloads/
echo.
echo   2. 点击黄色大按钮下载安装包
echo      （网站会自动识别你的 Windows 系统）
echo.
echo   3. 下载完成后，双击打开安装包
echo.
echo   4. [重要] 安装界面底部有一行字
echo      "Add Python to PATH"
echo      务必点一下前面的方框，打上对钩
echo.
echo   5. 点击 Install Now，等待完成
echo.
echo   6. 安装完成后，重新双击 start.bat
echo.
echo ========================================
pause
exit

:: ========== 找到 Python ==========
:found_python
set PYCMD=python
goto :start_server

:found_python3
set PYCMD=python3

:start_server
echo.
echo ========================================
echo   人工智能训练师5级 · 理论刷题
echo ========================================
echo.
echo   [√] Python 已就绪
echo.
echo   正在启动，浏览器将自动打开...
echo.
echo   此窗口保持打开，关闭后服务停止。
echo   下次刷题直接双击 start.bat。
echo ========================================
echo.

start "" "%URL%"
%PYCMD% -m http.server %PORT% --bind 127.0.0.1
pause
