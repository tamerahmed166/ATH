# 🤝 دليل المساهمة - Portfolio Tracker

نرحب بمساهماتك في تطوير Portfolio Tracker! هذا الدليل سيساعدك على المساهمة في المشروع.

## 🚀 كيفية المساهمة

### 1. Fork المشروع
1. اذهب إلى [GitHub Repository](https://github.com/yourusername/portfolio-tracker)
2. اضغط "Fork" في الزاوية العلوية اليمنى
3. انتظر حتى يتم إنشاء نسخة من المشروع

### 2. Clone النسخة المحلية
```bash
git clone https://github.com/yourusername/portfolio-tracker.git
cd portfolio-tracker
```

### 3. إعداد البيئة
```bash
# تثبيت التبعيات
flutter pub get

# تشغيل التطبيق للتأكد من عمله
flutter run
```

### 4. إنشاء Branch جديد
```bash
git checkout -b feature/your-feature-name
# أو
git checkout -b bugfix/your-bugfix-name
```

### 5. تطوير المميزات
- اكتب الكود
- اختبر التطبيق
- تأكد من عمل جميع المميزات
- اتبع معايير الكود

### 6. Commit التغييرات
```bash
git add .
git commit -m "Add: وصف مختصر للتغيير"
```

### 7. Push التغييرات
```bash
git push origin feature/your-feature-name
```

### 8. إنشاء Pull Request
1. اذهب إلى GitHub repository
2. اضغط "New Pull Request"
3. اختر branch المصدر والهدف
4. اكتب وصف مفصل للتغييرات
5. اضغط "Create Pull Request"

## 📋 أنواع المساهمات

### 🐛 إصلاح الأخطاء
- اكتشاف وإصلاح الأخطاء
- تحسين الأداء
- إصلاح مشاكل التوافق

### ✨ المميزات الجديدة
- إضافة مميزات جديدة
- تحسين المميزات الموجودة
- إضافة دعم لمنصات جديدة

### 📚 الوثائق
- تحسين README
- إضافة أمثلة للكود
- كتابة دليل المستخدم

### 🎨 التصميم
- تحسين الواجهة
- إضافة أيقونات جديدة
- تحسين تجربة المستخدم

### 🔧 التحسينات التقنية
- تحسين الأداء
- إضافة اختبارات
- تحسين البنية

## 📝 معايير الكود

### تسمية الملفات
```dart
// الملفات: snake_case
portfolio_screen.dart
asset_card.dart
api_service.dart
```

### تسمية المتغيرات
```dart
// المتغيرات: camelCase
String userName = 'Ahmed';
int totalValue = 1000;
bool isActive = true;
```

### تسمية الكلاسات
```dart
// الكلاسات: PascalCase
class PortfolioProvider extends ChangeNotifier {}
class AssetCard extends StatelessWidget {}
```

### تسمية الثوابت
```dart
// الثوابت: UPPER_SNAKE_CASE
static const String API_BASE_URL = 'https://api.example.com';
static const int MAX_RETRY_COUNT = 3;
```

### التعليقات
```dart
/// وصف مختصر للدالة
/// 
/// [param1] وصف المعامل الأول
/// [param2] وصف المعامل الثاني
/// 
/// Returns وصف القيمة المُرجعة
String calculateTotalValue(double price, int quantity) {
  // تعليق على السطر
  return price * quantity;
}
```

## 🧪 الاختبار

### اختبار الوحدة
```bash
# تشغيل جميع الاختبارات
flutter test

# تشغيل اختبارات محددة
flutter test test/models/asset_test.dart
```

### اختبار التطبيق
```bash
# اختبار على الأندرويد
flutter test --device-id android

# اختبار على iOS
flutter test --device-id ios
```

### اختبار الأداء
```bash
# تحليل الأداء
flutter analyze
flutter test --coverage
```

## 📋 قائمة التحقق

### قبل إرسال Pull Request
- [ ] الكود يتبع معايير المشروع
- [ ] جميع الاختبارات تمر بنجاح
- [ ] التطبيق يعمل بدون أخطاء
- [ ] الوثائق محدثة
- [ ] Commit messages واضحة
- [ ] لا توجد تعارضات

### قبل إرسال Issue
- [ ] البحث عن Issues مشابهة
- [ ] وصف مفصل للمشكلة
- [ ] خطوات إعادة إنتاج المشكلة
- [ ] معلومات النظام
- [ ] Screenshots إذا لزم الأمر

## 🏷️ تسمية Issues

### أنواع Issues
- `bug`: خطأ في التطبيق
- `feature`: ميزة جديدة
- `enhancement`: تحسين ميزة موجودة
- `documentation`: تحسين الوثائق
- `question`: سؤال أو استفسار

### أمثلة
```
[bug] التطبيق يتوقف عند إضافة أصل جديد
[feature] إضافة دعم للعملات الرقمية الجديدة
[enhancement] تحسين سرعة تحديث الأسعار
[documentation] إضافة دليل المستخدم
```

## 📞 التواصل

### قنوات التواصل
- **GitHub Issues**: للمشاكل والأسئلة
- **GitHub Discussions**: للمناقشات العامة
- **Email**: dev@portfolio-tracker.com
- **Discord**: Portfolio Tracker Community

### أوقات الاستجابة
- **Issues**: 24-48 ساعة
- **Pull Requests**: 2-3 أيام
- **Discussions**: 1-2 أيام
- **Email**: 1-3 أيام

## 🏆 الاعتراف

### المساهمون
- **المطورون**: قائمة المطورين النشطين
- **المختبرون**: قائمة المختبرين
- **المترجمون**: قائمة المترجمين
- **المصممون**: قائمة المصممين

### شكر خاص
- **Flutter Team**: لإطار العمل الرائع
- **Firebase Team**: للخدمات الممتازة
- **Yahoo Finance**: للبيانات المباشرة
- **Community**: للمساهمات والدعم

## 📄 الترخيص

### حقوق الطبع والنشر
- المشروع مرخص تحت رخصة MIT
- جميع المساهمات تصبح جزءاً من المشروع
- يجب احترام حقوق الطبع والنشر

### استخدام الكود
- يمكن استخدام الكود لأغراض تجارية
- يجب ذكر المصدر
- لا يمكن إزالة حقوق الطبع والنشر

## 🎯 أهداف المشروع

### الأهداف قصيرة المدى
- إصلاح جميع الأخطاء المعروفة
- تحسين الأداء والاستقرار
- إضافة مميزات جديدة
- تحسين الوثائق

### الأهداف طويلة المدى
- دعم المزيد من المنصات
- إضافة تحليل متقدم
- تحسين تجربة المستخدم
- بناء مجتمع نشط

---

**شكراً لمساهمتك في تطوير Portfolio Tracker!** 🚀📱💪
