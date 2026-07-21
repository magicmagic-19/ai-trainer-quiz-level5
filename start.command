#!/bin/bash
cd "$(dirname "$0")" || exit 1

PORT=5177
URL="http://127.0.0.1:${PORT}/"

echo "人工智能训练师5级刷题网页"
echo "固定访问地址: ${URL}"
echo

if command -v lsof >/dev/null 2>&1 && lsof -iTCP:${PORT} -sTCP:LISTEN -n -P >/dev/null 2>&1; then
  echo "本地服务已经在运行，正在打开固定地址..."
  if command -v open >/dev/null 2>&1; then
    open "${URL}"
  fi
  echo "可以继续用这个窗口，或直接访问 ${URL}"
  read -r -p "按回车键关闭这个窗口。"
  exit 0
fi

if command -v open >/dev/null 2>&1; then
  open "${URL}"
fi

echo "服务启动中。刷题时请一直使用上面的固定地址。"
echo "关闭这个窗口后，网页服务会停止；下次双击本文件即可再次打开。"
echo

python3 -m http.server "${PORT}" --bind 127.0.0.1
