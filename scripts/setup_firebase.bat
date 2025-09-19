@echo off
echo 🔥 إعداد Firebase للمشروع
echo ========================

echo [معلومات] التحقق من وجود Firebase CLI...
firebase --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [تحذير] Firebase CLI غير مثبت
    echo [معلومات] تثبيت Firebase CLI...
    npm install -g firebase-tools
)

echo [معلومات] تسجيل الدخول إلى Firebase...
firebase login

echo [معلومات] تهيئة Firebase في المشروع...
firebase init

echo.
echo [تعليمات] إعداد Firebase:
echo 1. اختر Firestore Database
echo 2. اختر Authentication
echo 3. اختر Hosting (اختياري)
echo 4. اختر Cloud Functions (اختياري)
echo 5. اختر Storage (اختياري)
echo.

echo [معلومات] إعداد Firebase مكتمل!
echo.
echo الخطوات التالية:
echo 1. اذهب إلى Firebase Console: https://console.firebase.google.com
echo 2. اختر مشروعك
echo 3. اذهب إلى Project Settings
echo 4. أضف تطبيق Android
echo 5. حمل google-services.json
echo 6. ضعه في مجلد android/app/
echo 7. أضف تطبيق iOS (إذا لزم الأمر)
echo 8. حمل GoogleService-Info.plist
echo 9. ضعه في مجلد ios/Runner/

pause
