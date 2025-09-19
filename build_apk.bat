@echo off
echo 🔨 بناء APK للتطبيق
echo ===================

REM التحقق من وجود Flutter
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [خطأ] Flutter غير مثبت أو غير موجود في PATH
    pause
    exit /b 1
)

echo [معلومات] تنظيف المشروع...
flutter clean

echo [معلومات] تثبيت التبعيات...
flutter pub get

echo [معلومات] بناء APK...
flutter build apk --release

if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo [نجح] تم بناء APK بنجاح
    echo [معلومات] موقع الملف: build\app\outputs\flutter-apk\app-release.apk
    echo.
    echo يمكنك الآن تثبيت التطبيق على جهاز الأندرويد باستخدام:
    echo adb install build\app\outputs\flutter-apk\app-release.apk
) else (
    echo [خطأ] فشل في بناء APK
)

pause
