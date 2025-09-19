@echo off
REM Portfolio Tracker Deployment Script for Windows
REM This script automates the deployment process

echo 🚀 Portfolio Tracker Deployment Script
echo ======================================

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter is not installed or not in PATH
    exit /b 1
)
echo [INFO] Flutter is installed

REM Check if Firebase CLI is installed
firebase --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Firebase CLI not found. Installing...
    npm install -g firebase-tools
)
echo [INFO] Firebase CLI is available

REM Clean and get dependencies
echo [INFO] Cleaning project...
flutter clean

echo [INFO] Getting dependencies...
flutter pub get

echo [INFO] Dependencies installed successfully

REM Build Android APK
echo [INFO] Building Android APK...
flutter build apk --release

if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo [INFO] Android APK built successfully
    echo [INFO] APK location: build\app\outputs\flutter-apk\app-release.apk
) else (
    echo [ERROR] Failed to build Android APK
    exit /b 1
)

REM Build Android App Bundle
echo [INFO] Building Android App Bundle...
flutter build appbundle --release

if exist "build\app\outputs\bundle\release\app-release.aab" (
    echo [INFO] Android App Bundle built successfully
    echo [INFO] AAB location: build\app\outputs\bundle\release\app-release.aab
) else (
    echo [ERROR] Failed to build Android App Bundle
    exit /b 1
)

REM Deploy to Firebase
echo [INFO] Deploying to Firebase...
if exist "firebase.json" (
    firebase deploy
    echo [INFO] Firebase deployment completed
) else (
    echo [WARNING] firebase.json not found, skipping Firebase deployment
)

echo [INFO] Deployment completed successfully! 🎉
pause
