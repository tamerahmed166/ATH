@echo off
echo 🚀 إعداد GitHub Repository
echo =========================

echo [معلومات] تهيئة Git repository...
git init

echo [معلومات] إضافة جميع الملفات...
git add .

echo [معلومات] إنشاء commit أولي...
git commit -m "Initial commit: Portfolio Tracker MVP"

echo.
echo [تعليمات] الآن قم بإنشاء repository جديد على GitHub:
echo 1. اذهب إلى https://github.com/new
echo 2. اختر اسم للمشروع: portfolio-tracker
echo 3. اختر Public أو Private
echo 4. لا تضع علامة على Initialize with README
echo 5. اضغط Create repository
echo.

set /p REPO_URL="أدخل رابط GitHub repository (https://github.com/username/portfolio-tracker.git): "

if not "%REPO_URL%"=="" (
    echo [معلومات] إضافة remote origin...
    git remote add origin %REPO_URL%
    
    echo [معلومات] رفع الملفات إلى GitHub...
    git push -u origin main
    
    if %errorlevel% equ 0 (
        echo [نجح] تم رفع المشروع إلى GitHub بنجاح
        echo [معلومات] يمكنك الآن الوصول للمشروع على: %REPO_URL%
    ) else (
        echo [خطأ] فشل في رفع الملفات إلى GitHub
        echo تأكد من صحة رابط Repository
    )
) else (
    echo [تحذير] لم يتم إدخال رابط Repository
    echo يمكنك إضافة remote لاحقاً باستخدام:
    echo git remote add origin YOUR_REPO_URL
    echo git push -u origin main
)

pause
