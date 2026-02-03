# -*- mode: python ; coding: utf-8 -*-
# SheetPick - PyInstaller spec file
# Mac/Windows両対応

import sys
import os

block_cipher = None

# プラットフォーム判定
is_mac = sys.platform == 'darwin'
is_windows = sys.platform == 'win32'

# データファイルのセパレータ（Mac: ":", Windows: ";"）
separator = ':' if is_mac else ';'

# hidden imports（プラットフォーム固有）
hidden_imports = [
    'webview',
    'flask',
    'openpyxl',
    'werkzeug',
]

if is_mac:
    hidden_imports.extend([
        'webview.platforms.cocoa',
        'Foundation',
        'AppKit',
        'WebKit',
    ])
elif is_windows:
    hidden_imports.extend([
        'webview.platforms.winforms',
        'webview.platforms.edgechromium',
        'clr',
        'pythonnet',
    ])

a = Analysis(
    ['app.py'],
    pathex=[],
    binaries=[],
    datas=[
        ('templates', 'templates'),
    ],
    hiddenimports=hidden_imports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='SheetPick',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,  # GUIアプリのためコンソールを非表示
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)

# Mac用の.appバンドル作成
if is_mac:
    app = BUNDLE(
        exe,
        name='SheetPick.app',
        icon=None,  # アイコンファイルがある場合はここに指定: 'icon.icns'
        bundle_identifier='com.sheetpick.app',
        info_plist={
            'CFBundleName': 'SheetPick',
            'CFBundleDisplayName': 'SheetPick',
            'CFBundleVersion': '1.0.0',
            'CFBundleShortVersionString': '1.0.0',
            'NSHighResolutionCapable': True,
            'LSMinimumSystemVersion': '10.13.0',
        },
    )
