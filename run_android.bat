@echo off
echo 🚀 تشغيل Portfolio Tracker على الأندرويد
echo ======================================

REM التحقق من وجود Flutter
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [خطأ] Flutter غير مثبت أو غير موجود في PATH
    echo يرجى تثبيت Flutter من: https://flutter.dev/docs/get-started/install/windows
    pause
    exit /b 1
)

echo [معلومات] Flutter مثبت بنجاح

REM تثبيت التبعيات
echo [معلومات] تثبيت التبعيات...
flutter pub get

REM تشغيل التطبيق
echo [معلومات] تشغيل التطبيق على الأندرويد...
flutter run

pause
