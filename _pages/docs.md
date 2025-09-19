---
layout: default
title: 📚 الوثائق
permalink: /docs
---

# 📚 وثائق Portfolio Tracker

## 🚀 دليل البدء السريع

### المتطلبات الأساسية
- Flutter SDK 3.0.0+
- Android Studio (للأندرويد)
- Xcode (للآيفون - Mac فقط)
- Firebase project

### خطوات التشغيل
1. **تثبيت Flutter**: تحميل من الموقع الرسمي
2. **تثبيت التبعيات**: `flutter pub get`
3. **تشغيل التطبيق**: `flutter run`
4. **استخدام ملفات التشغيل**: `run_android.bat`

## 📱 المميزات الأساسية

### إدارة المحفظة
- إضافة وتتبع الأصول المالية
- حساب القيمة الإجمالية
- تتبع التغييرات اليومية
- مؤشرات ATH

### التنبيهات
- تنبيهات ATH (All Time High)
- تنبيهات أسعار مخصصة
- إشعارات محلية و Firebase
- إدارة التنبيهات

### الأسعار المباشرة
- تحديث من Yahoo Finance API
- تحديث تلقائي كل دقيقة
- تحديث يدوي
- تخزين محلي

## 🛠️ التقنيات المستخدمة

### Frontend
- **Flutter**: إطار عمل متعدد المنصات
- **Material Design 3**: نظام التصميم
- **Provider**: إدارة الحالة
- **HTTP**: طلبات API

### Backend
- **Firebase**: خدمات Backend
- **Firestore**: قاعدة البيانات
- **Authentication**: المصادقة
- **Cloud Messaging**: الإشعارات

### APIs
- **Yahoo Finance**: بيانات الأسعار
- **REST APIs**: خدمات خارجية
- **WebSocket**: اتصال مباشر

## 🔧 إعداد البيئة

### تثبيت Flutter
```bash
# تحميل Flutter
# https://flutter.dev/docs/get-started/install/windows

# إضافة إلى PATH
# C:\flutter\bin

# التحقق من التثبيت
flutter doctor
```

### تثبيت Android Studio
1. تحميل من الموقع الرسمي
2. تثبيت Android SDK
3. إعداد Android Emulator
4. تشغيل `flutter doctor --android-licenses`

### إعداد Firebase
1. إنشاء مشروع Firebase
2. تفعيل Authentication
3. تفعيل Firestore Database
4. تفعيل Cloud Messaging
5. تحميل ملفات التكوين

## 📱 بناء التطبيق

### بناء APK
```bash
# تنظيف المشروع
flutter clean

# تثبيت التبعيات
flutter pub get

# بناء APK
flutter build apk --release
```

### بناء App Bundle
```bash
# بناء App Bundle
flutter build appbundle --release
```

### بناء iOS
```bash
# بناء iOS
flutter build ios --release
```

## 🚀 النشر والتوزيع

### Google Play Store
1. بناء App Bundle
2. رفع إلى Play Console
3. إعداد Store Listing
4. نشر التطبيق

### App Store
1. بناء iOS
2. رفع إلى App Store Connect
3. إعداد App Store
4. نشر التطبيق

### GitHub Releases
1. إنشاء Release
2. رفع APK/AAB
3. كتابة Release Notes
4. نشر Release

## 🔍 استكشاف الأخطاء

### مشاكل Flutter
- **Flutter غير موجود**: إضافة إلى PATH
- **Android SDK**: تثبيت Android Studio
- **iOS**: تثبيت Xcode
- **Dependencies**: `flutter pub get`

### مشاكل Firebase
- **Connection**: التحقق من ملفات التكوين
- **Authentication**: تفعيل في Console
- **Database**: إعداد قواعد Firestore
- **Messaging**: إعداد FCM

### مشاكل البناء
- **Clean**: `flutter clean`
- **Dependencies**: `flutter pub get`
- **Build**: `flutter build`
- **Run**: `flutter run`

## 📊 الأداء والتحسين

### تحسين الأداء
- **Lazy Loading**: تحميل عند الحاجة
- **Caching**: تخزين مؤقت
- **Background**: معالجة في الخلفية
- **Rendering**: عرض محسن

### مراقبة الأداء
- **Flutter Inspector**: فحص العناصر
- **Performance**: مراقبة الأداء
- **Memory**: إدارة الذاكرة
- **Network**: مراقبة الشبكة

## 🔐 الأمان والخصوصية

### حماية البيانات
- **Encryption**: تشفير البيانات
- **Secure Storage**: تخزين آمن
- **API Security**: حماية APIs
- **User Privacy**: خصوصية المستخدم

### Firebase Security
- **Rules**: قواعد Firestore
- **Authentication**: مصادقة آمنة
- **Permissions**: أذونات المستخدم
- **Data Access**: وصول البيانات

## 📈 التطوير المستقبلي

### المرحلة القادمة
- تحسين الأداء
- إضافة مميزات جديدة
- تحسين الواجهة
- إصلاح الأخطاء

### المرحلة المتوسطة
- تحليل تقني متقدم
- أخبار الأصول
- تقارير مفصلة
- إحصائيات متقدمة

### المرحلة البعيدة
- مميزات اجتماعية
- تحليل المخاطر
- تنويع المحفظة
- الوضع المظلم

## 🤝 المساهمة

### كيفية المساهمة
1. Fork المشروع
2. إنشاء Branch جديد
3. تطوير المميزات
4. إرسال Pull Request

### معايير الكود
- تسمية الملفات: snake_case
- تسمية المتغيرات: camelCase
- تسمية الكلاسات: PascalCase
- التعليقات: واضحة ومفيدة

### الاختبار
- اختبار الوحدة
- اختبار التطبيق
- اختبار الأداء
- اختبار التوافق

## 📞 الدعم والمساعدة

### قنوات التواصل
- **GitHub Issues**: للمشاكل
- **GitHub Discussions**: للمناقشات
- **Email**: tamerahmed166@gmail.com
- **Discord**: Portfolio Tracker Community

### أوقات الاستجابة
- **Issues**: 24-48 ساعة
- **Pull Requests**: 2-3 أيام
- **Discussions**: 1-2 أيام
- **Email**: 1-3 أيام

---

**استمتع بتطوير Portfolio Tracker!** 🚀📱💰
