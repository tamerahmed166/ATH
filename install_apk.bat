@echo off
echo 📱 تثبيت APK على الجهاز
echo ======================

REM التحقق من وجود ADB
adb version >nul 2>&1
if %errorlevel% neq 0 (
    echo [خطأ] ADB غير مثبت أو غير موجود في PATH
    echo يرجى تثبيت Android SDK أو Android Studio
    pause
    exit /b 1
)

REM التحقق من وجود الجهاز
echo [معلومات] التحقق من الأجهزة المتصلة...
adb devices

REM البحث عن ملف APK
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo [معلومات] تثبيت APK على الجهاز...
    adb install -r build\app\outputs\flutter-apk\app-release.apk
    
    if %errorlevel% equ 0 (
        echo [نجح] تم تثبيت التطبيق بنجاح على الجهاز
    ) else (
        echo [خطأ] فشل في تثبيت التطبيق
        echo تأكد من:
        echo 1. تفعيل خيارات المطور على الجهاز
        echo 2. تفعيل USB Debugging
        echo 3. السماح للتطبيق بالوصول للجهاز
    )
) else (
    echo [خطأ] ملف APK غير موجود
    echo يرجى تشغيل build_apk.bat أولاً
)

pause
