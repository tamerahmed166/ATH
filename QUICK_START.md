# 🚀 دليل البدء السريع - Portfolio Tracker

## 📋 المتطلبات الأساسية

### 1. تثبيت Flutter
```bash
# تحميل Flutter من الموقع الرسمي
# https://flutter.dev/docs/get-started/install/windows

# إضافة Flutter إلى PATH
# C:\flutter\bin
```

### 2. تثبيت Android Studio (للأندرويد)
- تحميل من: https://developer.android.com/studio
- تثبيت Android SDK
- إعداد Android Emulator

### 3. تثبيت Xcode (للآيفون - Mac فقط)
- تحميل من App Store
- إعداد iOS Simulator

## 🎯 التشغيل السريع

### الطريقة الأولى: التشغيل المباشر
```bash
# 1. فتح Terminal في مجلد المشروع
# 2. تشغيل الأوامر التالية:

flutter pub get
flutter run
```

### الطريقة الثانية: استخدام ملفات التشغيل
```bash
# للأندرويد
run_android.bat

# للآيفون (Mac فقط)
run_ios.bat
```

## 📱 بناء التطبيق للتثبيت

### بناء APK للأندرويد
```bash
# الطريقة الأولى: استخدام السكريبت
build_apk.bat

# الطريقة الثانية: الأوامر المباشرة
flutter build apk --release
```

### تثبيت APK على الجهاز
```bash
# الطريقة الأولى: استخدام السكريبت
install_apk.bat

# الطريقة الثانية: الأوامر المباشرة
adb install build/app/outputs/flutter-apk/app-release.apk
```

## 🔥 إعداد Firebase

### 1. إنشاء مشروع Firebase
1. اذهب إلى: https://console.firebase.google.com
2. اضغط "Create a project"
3. اختر اسم المشروع: "Portfolio Tracker"
4. فعّل Google Analytics (اختياري)

### 2. إضافة تطبيق Android
1. في Firebase Console، اضغط "Add app"
2. اختر Android
3. أدخل Package name: `com.example.portfolio_tracker`
4. حمل `google-services.json`
5. ضعه في `android/app/`

### 3. إضافة تطبيق iOS (اختياري)
1. في Firebase Console، اضغط "Add app"
2. اختر iOS
3. أدخل Bundle ID: `com.example.portfolioTracker`
4. حمل `GoogleService-Info.plist`
5. ضعه في `ios/Runner/`

### 4. تفعيل الخدمات
- **Authentication**: Email/Password
- **Firestore Database**: Create database
- **Cloud Messaging**: Enable notifications

## 🚀 رفع المشروع على GitHub

### الطريقة الأولى: استخدام السكريبت
```bash
setup_github.bat
```

### الطريقة الثانية: الأوامر المباشرة
```bash
git init
git add .
git commit -m "Initial commit: Portfolio Tracker MVP"
git remote add origin https://github.com/yourusername/portfolio-tracker.git
git push -u origin main
```

## 🔧 استكشاف الأخطاء

### مشكلة: Flutter غير موجود
```bash
# الحل: إضافة Flutter إلى PATH
# 1. اذهب إلى System Properties > Environment Variables
# 2. أضف C:\flutter\bin إلى PATH
# 3. أعد تشغيل Terminal
```

### مشكلة: Android SDK غير موجود
```bash
# الحل: تثبيت Android Studio
# 1. حمل Android Studio
# 2. تثبيت Android SDK
# 3. تشغيل: flutter doctor --android-licenses
```

### مشكلة: Firebase غير متصل
```bash
# الحل: التحقق من ملفات التكوين
# 1. تأكد من وجود google-services.json في android/app/
# 2. تأكد من وجود GoogleService-Info.plist في ios/Runner/
# 3. تحديث firebase_options.dart
```

## 📱 اختبار التطبيق

### على الأندرويد
1. تفعيل Developer Options
2. تفعيل USB Debugging
3. توصيل الجهاز بالكمبيوتر
4. تشغيل `flutter run`

### على الآيفون
1. فتح Xcode
2. فتح `ios/Runner.xcworkspace`
3. اختيار الجهاز أو Simulator
4. الضغط على Run

## 🎉 تهانينا!

لقد نجحت في إعداد وتشغيل Portfolio Tracker! 

### الخطوات التالية:
1. **إضافة الأصول**: اذهب إلى تبويب Markets
2. **إنشاء التنبيهات**: اذهب إلى تبويب Alerts
3. **مراقبة المحفظة**: اذهب إلى تبويب Portfolio

### المميزات المتاحة:
- ✅ تتبع الأسهم والكريبتو والسلع والعملات
- ✅ تنبيهات ATH (All Time High)
- ✅ تحديث الأسعار المباشر
- ✅ إدارة المحفظة
- ✅ واجهة سهلة الاستخدام

---

**استمتع باستخدام Portfolio Tracker!** 🚀📱
