# 📱 Portfolio Tracker - متتبع المحفظة المالية

تطبيق Flutter بسيط يركز على تتبع المحفظة المالية والتنبيهات عند الوصول لأعلى سعر تاريخي (ATH) للأسهم والنفط والذهب والعملات.

## ✨ المميزات الأساسية

### 🎯 المميزات الأساسية (MVP)
- **إدارة الأصول**: إضافة وتتبع الأسهم والكريبتو والسلع والعملات
- **الأسعار المباشرة**: تحديث الأسعار المباشر من Yahoo Finance API
- **تنبيهات ATH**: إشعارات عند وصول الأصول لأعلى سعر تاريخي
- **تنبيهات مخصصة**: تحديد تنبيهات لأسعار محددة
- **نظرة عامة على المحفظة**: تتبع القيمة الإجمالية والتغييرات اليومية

### 🖥️ واجهة المستخدم
- **تبويب المحفظة**: لوحة التحكم الرئيسية مع قائمة الأصول وملخص المحفظة
- **تبويب الأسواق**: تصفح وإضافة الأصول حسب الفئة (أسهم، كريبتو، سلع، فوركس)
- **تبويب التنبيهات**: إدارة التنبيهات النشطة والمُشغلة

## 🛠️ التقنيات المستخدمة

- **Frontend**: Flutter (تطبيق متعدد المنصات)
- **Backend**: Firebase (المصادقة، Firestore، Cloud Functions)
- **APIs**: Yahoo Finance API للأسعار المباشرة
- **الإشعارات**: Firebase Cloud Messaging + الإشعارات المحلية

## 🚀 خطوات التشغيل

### 1. تثبيت Flutter SDK
```bash
# تحميل Flutter من الموقع الرسمي
# https://flutter.dev/docs/get-started/install/windows

# إضافة Flutter إلى PATH
# C:\flutter\bin
```

### 2. تثبيت التبعيات
```bash
flutter pub get
```

### 3. إعداد Firebase
1. إنشاء مشروع Firebase جديد
2. تفعيل Authentication و Firestore و Cloud Messaging
3. تحميل ملفات التكوين:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`

### 4. تشغيل التطبيق
```bash
# للأندرويد
flutter run

# للآيفون (Mac فقط)
flutter run -d ios
```

## 📱 تثبيت التطبيق على الأجهزة

### الأندرويد
```bash
# بناء APK
flutter build apk --release

# تثبيت على الجهاز
adb install build/app/outputs/flutter-apk/app-release.apk
```

### الآيفون
```bash
# بناء للآيفون
flutter build ios --release

# فتح في Xcode
open ios/Runner.xcworkspace
```

## 🔧 إعداد GitHub

### 1. إنشاء Repository
```bash
git init
git add .
git commit -m "Initial commit: Portfolio Tracker MVP"
git remote add origin https://github.com/yourusername/portfolio-tracker.git
git push -u origin main
```

### 2. إعداد GitHub Actions
- تم إعداد CI/CD تلقائياً
- بناء تلقائي للأندرويد والآيفون
- نشر تلقائي على Firebase

## 📊 هيكل المشروع

```
lib/
├── main.dart                 # نقطة دخول التطبيق
├── models/                   # نماذج البيانات
│   ├── asset.dart           # نموذج الأصول
│   └── alert.dart           # نموذج التنبيهات
├── providers/                # إدارة الحالة
│   ├── portfolio_provider.dart
│   └── alerts_provider.dart
├── screens/                  # شاشات التطبيق
│   ├── main_screen.dart     # التنقل الرئيسي
│   ├── portfolio_screen.dart
│   ├── markets_screen.dart
│   └── alerts_screen.dart
├── services/                 # الخدمات
│   ├── api_service.dart     # Yahoo Finance API
│   └── notification_service.dart
└── widgets/                  # عناصر واجهة قابلة لإعادة الاستخدام
    ├── asset_card.dart
    ├── portfolio_summary.dart
    └── alert_card.dart
```

## 🎯 المميزات الرئيسية

### تحديث الأسعار المباشر
- تكامل مع Yahoo Finance API
- تحديث تلقائي كل دقيقة
- إمكانية التحديث اليدوي

### كشف ATH
- مقارنة السعر الحالي مع أعلى سعر في 52 أسبوع
- مؤشرات بصرية للأصول عند ATH
- تشغيل تنبيهات تلقائية

### الإشعارات
- إشعارات محلية فورية
- Firebase Cloud Messaging للخلفية
- أصوات وإيقونات مخصصة

### إدارة المحفظة
- إضافة/إزالة الأصول
- حساب القيمة الإجمالية للمحفظة
- تتبع التغييرات اليومية
- تصنيف الأصول

## 🔮 المميزات المستقبلية

### المرحلة الثانية
- **إحصائيات متقدمة**: أداء 24س، 7أيام، سنة
- **التحليل الفني**: RSI، المتوسطات المتحركة
- **تغذية الأخبار**: ربط الأخبار المتعلقة بكل أصل
- **تصدير المحفظة**: تقارير PDF/Excel

### المرحلة الثالثة
- **المميزات الاجتماعية**: مشاركة أداء المحفظة
- **تنبيهات متقدمة**: تنبيهات التغيير المئوي، تنبيهات الحجم
- **تحليلات المحفظة**: تحليل المخاطر، مقاييس التنويع
- **الوضع المظلم**: تخصيص المظهر

## 🛠️ استكشاف الأخطاء

### المشاكل الشائعة

1. **Flutter غير موجود**:
   - إضافة Flutter إلى PATH
   - إعادة تشغيل Terminal

2. **Android SDK غير موجود**:
   - تثبيت Android Studio
   - تشغيل `flutter doctor --android-licenses`

3. **تكوين Firebase**:
   - التأكد من وجود `google-services.json` في `android/app/`
   - تحديث `firebase_options.dart` بتفاصيل المشروع

4. **أخطاء البناء**:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## 📞 الدعم

للمشاكل والأسئلة:
- إنشاء issue في المستودع
- مراجعة الوثائق
- التواصل مع فريق التطوير

## 📄 الترخيص

هذا المشروع مرخص تحت رخصة MIT - راجع ملف LICENSE للتفاصيل.

---

**جاهز للتشغيل!** 🚀 اتبع هذه الخطوات لتشغيل تطبيق Portfolio Tracker على الأجهزة المحمولة.
