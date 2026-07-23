# PowerShell script - start.ps1
# UTF-8 with BOM encoding

$host.UI.RawUI.WindowTitle = '人工智能训练师5级 理论刷题'

$PORT = 5177
$URL = "http://127.0.0.1:${PORT}/"

Write-Host ""
Write-Host "********************************************" -ForegroundColor Cyan
Write-Host "  人工智能训练师5级 - 理论刷题" -ForegroundColor White
Write-Host "********************************************" -ForegroundColor Cyan
Write-Host ""

# ---- 检测 Python ----
$pycmd = $null

try {
    $null = python --version 2>&1
    if ($LASTEXITCODE -eq 0) { $pycmd = "python" }
} catch {}

if (-not $pycmd) {
    try {
        $null = python3 --version 2>&1
        if ($LASTEXITCODE -eq 0) { $pycmd = "python3" }
    } catch {}
}

# ---- 未找到 Python ----
if (-not $pycmd) {
    Write-Host "  [X] 未检测到 Python 3" -ForegroundColor Red
    Write-Host ""
    Write-Host "  ---------- 安装指引 ----------"
    Write-Host ""
    Write-Host "  1. 打开浏览器，访问:"
    Write-Host "     https://www.python.org/downloads/"
    Write-Host ""
    Write-Host "  2. 点击黄色大按钮下载安装包"
    Write-Host ""
    Write-Host "  3. 双击安装包运行"
    Write-Host ""
    Write-Host "  4. [重要!] 勾选 Add Python to PATH"
    Write-Host ""
    Write-Host "  5. 点击 Install Now，等待完成"
    Write-Host ""
    Write-Host "  6. 重新双击 start.bat 即可"
    Write-Host ""
    Read-Host "按回车键关闭窗口"
    exit 1
}

# ---- 找到了 Python，启动 ----
Write-Host "  [OK] Python 3 已就绪" -ForegroundColor Green
Write-Host ""
Write-Host "  正在启动服务，浏览器将自动打开..." -ForegroundColor White
Write-Host ""
Write-Host "  此窗口保持打开，关闭后服务停止。" -ForegroundColor Yellow
Write-Host "  下次刷题直接双击 start.bat。" -ForegroundColor Yellow
Write-Host ""

# 先启动 HTTP 服务（后台），避免竞态条件导致浏览器先于服务器打开
$serverJob = Start-Job -ScriptBlock {
    param($cmd, $port)
    & $cmd -m http.server $port --bind 127.0.0.1
} -ArgumentList $pycmd, $PORT

Start-Sleep -Milliseconds 500

# 打开浏览器
Start-Process $URL

# 等待服务结束
Wait-Job $serverJob | Out-Null
Receive-Job $serverJob
