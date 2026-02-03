#!/bin/bash
# SheetPick - Mac用ビルドスクリプト

set -e

echo "=========================================="
echo "SheetPick - Mac Build Script"
echo "=========================================="

# スクリプトのディレクトリに移動
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# 仮想環境の作成（オプション）
if [ ! -d "venv" ]; then
    echo "[1/4] 仮想環境を作成中..."
    python3 -m venv venv
fi

# 仮想環境を有効化
echo "[2/4] 仮想環境を有効化..."
source venv/bin/activate

# 依存関係のインストール
echo "[3/4] 依存関係をインストール中..."
pip install --upgrade pip
pip install -r requirements.txt

# PyInstallerでビルド
echo "[4/4] アプリケーションをビルド中..."
pyinstaller \
    --name "SheetPick" \
    --windowed \
    --onefile \
    --add-data "templates:templates" \
    --hidden-import "webview" \
    --hidden-import "webview.platforms.cocoa" \
    --clean \
    --noconfirm \
    app.py

echo ""
echo "=========================================="
echo "ビルド完了!"
echo "アプリケーションは dist/SheetPick.app にあります"
echo "=========================================="

# distフォルダを開く
open dist/
