@echo off
echo 🚀 سكريبت نشر Portfolio Tracker
echo ================================

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
) else (
    echo [خطأ] فشل في بناء APK
    pause
    exit /b 1
)

echo [معلومات] بناء App Bundle...
flutter build appbundle --release

if exist "build\app\outputs\bundle\release\app-release.aab" (
    echo [نجح] تم بناء App Bundle بنجاح
) else (
    echo [خطأ] فشل في بناء App Bundle
)

echo [معلومات] النشر مكتمل! 🎉
echo.
echo الملفات المتاحة:
echo - APK: build\app\outputs\flutter-apk\app-release.apk
echo - AAB: build\app\outputs\bundle\release\app-release.aab
echo.
echo يمكنك الآن:
echo 1. تثبيت APK على الجهاز
echo 2. رفع AAB إلى Google Play Console
echo 3. مشاركة APK مع المستخدمين

pause
