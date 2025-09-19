@echo off
REM Portfolio Tracker Installation Script for Windows
REM This script helps users install the app on their devices

echo 📱 Portfolio Tracker Installation Script
echo ========================================

REM Check if device is connected
echo [INFO] Checking for connected devices...

REM Check for Android devices
adb devices | findstr "device" >nul 2>&1
if %errorlevel% equ 0 (
    echo [INFO] Android device detected
    goto :install_android
) else (
    echo [WARNING] No Android device detected
    goto :show_instructions
)

:install_android
echo [INFO] Installing on Android device...

if exist "build\app\outputs\flutter-apk\app-release.apk" (
    adb install -r build\app\outputs\flutter-apk\app-release.apk
    echo [INFO] Android app installed successfully
) else (
    echo [ERROR] APK file not found. Please build the app first.
    goto :show_instructions
)

echo [INFO] Installation completed! 🎉
goto :end

:show_instructions
echo.
echo [INSTRUCTION] Manual Installation Instructions:
echo.
echo Android:
echo 1. Enable Developer Options on your Android device
echo 2. Enable USB Debugging
echo 3. Connect device via USB
echo 4. Run: adb install app-release.apk
echo.
echo GitHub Release:
echo 1. Go to: https://github.com/yourusername/portfolio-tracker/releases
echo 2. Download the latest APK
echo 3. Install on your device
echo.

:end
pause
