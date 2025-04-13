@echo off
echo ----------------------------------------
echo [INFO] 開始處理 Git 專案：%cd%
echo ----------------------------------------

REM 確保 upstream remote 正確設好（不會用來 push）
git remote | findstr "upstream" > nul
IF ERRORLEVEL 1 (
    echo [INFO] 加入 upstream 來源...
    git remote add upstream https://github.com/google/A2A.git
) ELSE (
    echo [INFO] upstream 已存在，略過加入。
)

REM 加強防呆：設為不允許 push 到 upstream
git remote set-url --push upstream no_push

REM 拉原始作者更新到本地
echo [INFO] Fetch + Pull upstream/main ...
git fetch upstream
git pull upstream main

REM 顯示狀態
echo [INFO] 當前 Git 狀態如下：
git status

REM 保留確認動作（可拿掉）
pause

REM 提交自己的變更並推到 fork（origin）
echo [INFO] 開始 commit 並 push 到 origin ...
git add .
git commit -m "更新"
git push origin main

echo ----------------------------------------
echo [完成] 與 upstream 同步，並推送至 origin。
echo ----------------------------------------
pause
