@echo off
chcp 65001 >nul
cd /d "%~dp0"

set PORT=5177
set URL=http://127.0.0.1:%PORT%/

echo 人工智能训练师5级刷题网页
echo 固定访问地址: %URL%
echo.

:: 检查端口是否已被占用
netstat -ano | findstr ":%PORT% " | findstr "LISTENING" >nul
if %errorlevel% equ 0 (
    echo 本地服务已经在运行，正在打开固定地址...
    start "" "%URL%"
    echo 可以继续用这个窗口，或直接访问 %URL%
    pause
    exit /b 0
)

:: 打开浏览器
start "" "%URL%"

echo 服务启动中。刷题时请一直使用上面的固定地址。
echo 关闭这个窗口后，网页服务会停止；下次双击本文件即可再次打开。
echo.

:: 检查 Python 是否可用
where python >nul 2>&1
if %errorlevel% neq 0 (
    where python3 >nul 2>&1
    if %errorlevel% neq 0 (
        echo [错误] 未找到 Python，请先安装 Python 3
        echo 下载地址：https://www.python.org/downloads/
        pause
        exit /b 1
    )
    python3 -m http.server %PORT% --bind 127.0.0.1
) else (
    python -m http.server %PORT% --bind 127.0.0.1
)
