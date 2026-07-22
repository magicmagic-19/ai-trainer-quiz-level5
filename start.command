#!/bin/bash
cd "$(dirname "$0")" || exit 1

PORT=5177
URL="http://127.0.0.1:${PORT}/"

echo
echo "========================================"
echo "  人工智能训练师5级 · 理论刷题"
echo "========================================"
echo
echo "  固定地址: ${URL}"
echo

# 第一步：检查 Python3
PYCMD=""
if command -v python3 >/dev/null 2>&1; then
  PYCMD="python3"
elif command -v python >/dev/null 2>&1; then
  PYCMD="python"
fi

if [ -z "$PYCMD" ]; then
  echo "  [X] 未检测到 Python"
  echo
  echo "  ═══════════════════════════════"
  echo "  Python 3 安装指引（Mac 版）"
  echo "  ═══════════════════════════════"
  echo
  echo "  方法一（推荐，最快）："
  echo "  1. 打开终端（在启动台搜索「终端」或 Terminal）"
  echo "  2. 粘贴以下命令并回车："
  echo "     xcode-select --install"
  echo "  3. 弹出窗口点「安装」，等待完成"
  echo
  echo "  方法二："
  echo "  1. 浏览器打开 https://www.python.org/downloads/"
  echo "  2. 点击黄色大按钮下载 macOS 安装包"
  echo "  3. 双击安装包，一路点「继续」完成安装"
  echo
  echo "  安装完成后，重新双击 start.command 即可"
  echo
  read -r -p "按回车键关闭此窗口。"
  exit 1
fi

echo "  [√] Python 已就绪 (${PYCMD})"
echo

# 第二步：检查端口是否已被占用
if command -v lsof >/dev/null 2>&1 && lsof -iTCP:${PORT} -sTCP:LISTEN -n -P >/dev/null 2>&1; then
  echo "  本地服务已在运行，直接打开..."
  if command -v open >/dev/null 2>&1; then
    open "${URL}"
  fi
  read -r -p "按回车键关闭此窗口。"
  exit 0
fi

# 第三步：打开浏览器 + 启动服务
if command -v open >/dev/null 2>&1; then
  open "${URL}"
fi

echo
echo "  此窗口保持打开，关闭后服务停止。"
echo "  下次刷题直接双击 start.command 即可。"
echo

$PYCMD -m http.server "${PORT}" --bind 127.0.0.1
