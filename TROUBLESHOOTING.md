# 🔧 استكشاف الأخطاء وإصلاحها

## 🚨 المشاكل الشائعة

### 1. مشكلة: Flutter غير موجود
```
خطأ: 'flutter' is not recognized as an internal or external command
```

**الحل:**
1. تحميل Flutter من الموقع الرسمي
2. إضافة Flutter إلى PATH:
   - اذهب إلى System Properties > Environment Variables
   - أضف `C:\flutter\bin` إلى PATH
   - أعد تشغيل Terminal

### 2. مشكلة: Android SDK غير موجود
```
خطأ: Android SDK not found
```

**الحل:**
1. تثبيت Android Studio
2. تثبيت Android SDK
3. تشغيل: `flutter doctor --android-licenses`
4. قبول جميع التراخيص

### 3. مشكلة: Firebase غير متصل
```
خطأ: Firebase connection failed
```

**الحل:**
1. التحقق من وجود `google-services.json` في `android/app/`
2. التحقق من وجود `GoogleService-Info.plist` في `ios/Runner/`
3. تحديث `firebase_options.dart` بتفاصيل المشروع
4. التحقق من اتصال الإنترنت

### 4. مشكلة: بناء APK فاشل
```
خطأ: Build failed
```

**الحل:**
1. تنظيف المشروع: `flutter clean`
2. تثبيت التبعيات: `flutter pub get`
3. التحقق من إعدادات Android
4. إعادة تشغيل Android Studio

### 5. مشكلة: تثبيت APK فاشل
```
خطأ: Installation failed
```

**الحل:**
1. تفعيل Developer Options على الجهاز
2. تفعيل USB Debugging
3. السماح للتطبيق بالوصول للجهاز
4. التحقق من توصيل الجهاز بالكمبيوتر

## 🔍 خطوات التشخيص

### 1. فحص Flutter
```bash
flutter doctor
```

**النتائج المتوقعة:**
- ✅ Flutter (Channel stable)
- ✅ Android toolchain
- ✅ Android Studio
- ✅ Connected device

### 2. فحص الأجهزة المتصلة
```bash
flutter devices
```

**النتائج المتوقعة:**
- Android device (USB)
- iOS Simulator (macOS only)

### 3. فحص التبعيات
```bash
flutter pub deps
```

**النتائج المتوقعة:**
- جميع التبعيات مثبتة
- لا توجد تعارضات

## 🛠️ حلول المشاكل المتقدمة

### مشكلة: تطبيق لا يعمل
**الأعراض:** التطبيق يفتح لكن لا يعرض البيانات

**الحل:**
1. التحقق من اتصال الإنترنت
2. التحقق من إعدادات Firebase
3. فحص logs: `flutter logs`
4. إعادة تشغيل التطبيق

### مشكلة: التنبيهات لا تعمل
**الأعراض:** لا تظهر التنبيهات

**الحل:**
1. التحقق من أذونات الإشعارات
2. التحقق من إعدادات Firebase Cloud Messaging
3. اختبار الإشعارات المحلية
4. التحقق من إعدادات الجهاز

### مشكلة: الأسعار لا تتحدث
**الأعراض:** الأسعار ثابتة ولا تتغير

**الحل:**
1. التحقق من اتصال الإنترنت
2. التحقق من Yahoo Finance API
3. إعادة تشغيل التطبيق
4. التحقق من logs للأخطاء

## 📱 مشاكل الأجهزة

### مشاكل الأندرويد

#### الجهاز غير معترف به
```bash
# الحل:
adb devices
# إذا لم يظهر الجهاز:
# 1. تفعيل USB Debugging
# 2. السماح للتطبيق بالوصول
# 3. إعادة توصيل الجهاز
```

#### تثبيت APK فاشل
```bash
# الحل:
adb install -r app-release.apk
# إذا فشل:
# 1. إلغاء تثبيت التطبيق القديم
# 2. تفعيل "Install from unknown sources"
# 3. إعادة المحاولة
```

### مشاكل iOS

#### Xcode غير مثبت
```bash
# الحل:
# 1. تحميل Xcode من App Store
# 2. تثبيت Xcode Command Line Tools
# 3. إعداد iOS Simulator
```

#### توقيع التطبيق
```bash
# الحل:
# 1. فتح Xcode
# 2. اختيار Team في Signing & Capabilities
# 3. إعداد Bundle Identifier
```

## 🔥 مشاكل Firebase

### مشكلة: Authentication فاشل
**الحل:**
1. التحقق من إعدادات Firebase Console
2. تفعيل Email/Password authentication
3. التحقق من `firebase_options.dart`
4. إعادة تشغيل التطبيق

### مشكلة: Firestore فاشل
**الحل:**
1. التحقق من قواعد Firestore
2. التحقق من أذونات المستخدم
3. اختبار الاتصال
4. فحص logs للأخطاء

### مشكلة: Cloud Messaging فاشل
**الحل:**
1. التحقق من إعدادات FCM
2. التحقق من أذونات الإشعارات
3. اختبار الإشعارات
4. التحقق من tokens

## 📊 أدوات التشخيص

### 1. Flutter Inspector
```bash
flutter inspector
```
- فحص عناصر الواجهة
- تحليل الأداء
- اكتشاف المشاكل

### 2. Flutter Logs
```bash
flutter logs
```
- عرض logs التطبيق
- اكتشاف الأخطاء
- مراقبة الأداء

### 3. Flutter Analyze
```bash
flutter analyze
```
- فحص الكود
- اكتشاف المشاكل
- تحسين الأداء

## 🆘 الحصول على المساعدة

### 1. فحص الوثائق
- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [GitHub Issues](https://github.com/yourusername/portfolio-tracker/issues)

### 2. البحث عن الحلول
- Stack Overflow
- Flutter Community
- Firebase Support

### 3. إنشاء Issue
1. اذهب إلى GitHub repository
2. اضغط "Issues"
3. اضغط "New Issue"
4. اكتب وصف المشكلة
5. أرفق screenshots إذا لزم الأمر

## 📞 الدعم الفني

### معلومات الاتصال
- **GitHub**: [portfolio-tracker](https://github.com/yourusername/portfolio-tracker)
- **Email**: support@portfolio-tracker.com
- **Discord**: Portfolio Tracker Community

### ساعات العمل
- **الأحد - الخميس**: 9:00 ص - 6:00 م
- **الجمعة - السبت**: 10:00 ص - 4:00 م

---

**نحن هنا لمساعدتك!** 🚀📱💪
