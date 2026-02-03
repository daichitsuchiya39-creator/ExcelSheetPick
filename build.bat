@echo off
REM SheetPick - Windows用ビルドスクリプト

echo ==========================================
echo SheetPick - Windows Build Script
echo ==========================================

REM スクリプトのディレクトリに移動
cd /d "%~dp0"

REM 仮想環境の作成（オプション）
if not exist "venv" (
    echo [1/4] 仮想環境を作成中...
    python -m venv venv
)

REM 仮想環境を有効化
echo [2/4] 仮想環境を有効化...
call venv\Scripts\activate.bat

REM 依存関係のインストール
echo [3/4] 依存関係をインストール中...
pip install --upgrade pip
pip install -r requirements.txt

REM PyInstallerでビルド
echo [4/4] アプリケーションをビルド中...
pyinstaller ^
    --name "SheetPick" ^
    --windowed ^
    --onefile ^
    --add-data "templates;templates" ^
    --hidden-import "webview" ^
    --hidden-import "webview.platforms.winforms" ^
    --hidden-import "webview.platforms.edgechromium" ^
    --clean ^
    --noconfirm ^
    app.py

echo.
echo ==========================================
echo ビルド完了!
echo アプリケーションは dist\SheetPick.exe にあります
echo ==========================================

REM distフォルダを開く
explorer dist

pause
