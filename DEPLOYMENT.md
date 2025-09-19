# 🚀 Portfolio Tracker - Deployment Guide

This guide covers deploying the Portfolio Tracker app to GitHub and mobile devices.

## 📱 Mobile Device Deployment

### Android Deployment

#### Method 1: Direct APK Installation
1. **Build APK**:
   ```bash
   flutter build apk --release
   ```

2. **Install on Device**:
   - Enable "Developer Options" on Android device
   - Enable "USB Debugging"
   - Connect device via USB
   - Run: `flutter install`

#### Method 2: Google Play Store
1. **Build App Bundle**:
   ```bash
   flutter build appbundle --release
   ```

2. **Upload to Play Console**:
   - Go to [Google Play Console](https://play.google.com/console)
   - Create new app
   - Upload the `.aab` file from `build/app/outputs/bundle/release/`

#### Method 3: GitHub Releases
1. **Create Release**:
   - Go to GitHub repository
   - Click "Releases" → "Create a new release"
   - Tag version (e.g., `v1.0.0`)
   - Upload APK file
   - Users can download and install

### iOS Deployment

#### Method 1: TestFlight (Recommended)
1. **Build for iOS**:
   ```bash
   flutter build ios --release
   ```

2. **Archive in Xcode**:
   - Open `ios/Runner.xcworkspace` in Xcode
   - Select "Any iOS Device" as target
   - Product → Archive
   - Upload to App Store Connect

3. **TestFlight Distribution**:
   - Go to [App Store Connect](https://appstoreconnect.apple.com)
   - Upload build
   - Add testers via TestFlight

#### Method 2: Direct Installation (Development)
1. **Build and Install**:
   ```bash
   flutter run --release
   ```

2. **Requirements**:
   - Apple Developer Account
   - Device registered in developer portal
   - Valid provisioning profile

## 🌐 GitHub Repository Setup

### 1. Create Repository
```bash
# Initialize git
git init
git add .
git commit -m "Initial commit: Portfolio Tracker MVP"

# Add remote
git remote add origin https://github.com/yourusername/portfolio-tracker.git
git push -u origin main
```

### 2. Repository Structure
```
portfolio-tracker/
├── .github/
│   └── workflows/
│       ├── build.yml          # CI/CD pipeline
│       └── release.yml        # Release automation
├── android/                   # Android configuration
├── ios/                       # iOS configuration
├── lib/                       # Flutter source code
├── firebase.json             # Firebase configuration
├── firestore.rules           # Firestore security rules
├── firestore.indexes.json    # Database indexes
├── pubspec.yaml              # Dependencies
└── README.md                 # Documentation
```

### 3. GitHub Actions Setup

#### Secrets Configuration
Add these secrets in GitHub repository settings:

1. **FIREBASE_TOKEN**: Firebase CLI token
   ```bash
   firebase login:ci
   ```

2. **GOOGLE_SERVICES_JSON**: Android Firebase config
   - Base64 encode your `google-services.json`
   - Add as repository secret

3. **APPLE_CERTIFICATE**: iOS signing certificate
   - Export from Keychain Access
   - Base64 encode and add as secret

#### Automated Builds
- **Push to main**: Triggers build and test
- **Create tag**: Triggers release build
- **Pull Request**: Runs tests and builds

## 🔧 Configuration Files

### Firebase Setup
1. **Create Firebase Project**:
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Create project "Portfolio Tracker"

2. **Enable Services**:
   - Authentication (Email/Password)
   - Firestore Database
   - Cloud Messaging
   - Hosting (optional)

3. **Download Config Files**:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`

### Environment Configuration
Create `.env` file for environment variables:
```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
YAHOO_FINANCE_API_URL=https://query1.finance.yahoo.com
```

## 📦 Release Process

### 1. Version Management
```bash
# Update version in pubspec.yaml
version: 1.0.0+1

# Create git tag
git tag v1.0.0
git push origin v1.0.0
```

### 2. Automated Release
GitHub Actions will automatically:
- Build APK and AAB files
- Create GitHub release
- Upload artifacts
- Generate release notes

### 3. Manual Release
```bash
# Build release
flutter build apk --release
flutter build appbundle --release

# Create release
gh release create v1.0.0 \
  build/app/outputs/flutter-apk/app-release.apk \
  build/app/outputs/bundle/release/app-release.aab \
  --title "Portfolio Tracker v1.0.0" \
  --notes "Initial release with ATH alerts"
```

## 🚀 Deployment Strategies

### Development Deployment
```bash
# Local development
flutter run

# Hot reload
r

# Hot restart
R
```

### Staging Deployment
```bash
# Build for testing
flutter build apk --debug
flutter build ios --debug

# Install on test devices
flutter install
```

### Production Deployment
```bash
# Build release
flutter build apk --release
flutter build appbundle --release
flutter build ios --release

# Deploy to stores
# Android: Upload AAB to Play Console
# iOS: Upload to App Store Connect
```

## 📱 Device Testing

### Android Testing
1. **Enable Developer Options**:
   - Settings → About Phone → Tap "Build Number" 7 times

2. **Enable USB Debugging**:
   - Settings → Developer Options → USB Debugging

3. **Install APK**:
   ```bash
   flutter install
   ```

### iOS Testing
1. **Register Device**:
   - Add device UDID to Apple Developer Portal

2. **Create Provisioning Profile**:
   - Download and install in Xcode

3. **Install App**:
   ```bash
   flutter run --release
   ```

## 🔒 Security Considerations

### Firebase Security Rules
- Users can only access their own data
- Public market data is read-only
- Authentication required for user data

### API Security
- Yahoo Finance API (no authentication required)
- Rate limiting implemented
- Error handling for API failures

### App Security
- No sensitive data stored locally
- Firebase handles authentication
- Secure communication with APIs

## 📊 Monitoring and Analytics

### Firebase Analytics
- User engagement tracking
- Crash reporting
- Performance monitoring

### Custom Analytics
- Portfolio performance metrics
- Alert trigger rates
- User behavior analysis

## 🆘 Troubleshooting

### Common Issues

1. **Build Failures**:
   ```bash
   flutter clean
   flutter pub get
   flutter build apk --release
   ```

2. **Firebase Connection**:
   - Check `google-services.json` is in correct location
   - Verify Firebase project configuration
   - Check internet connectivity

3. **iOS Code Signing**:
   - Verify Apple Developer account
   - Check provisioning profiles
   - Ensure device is registered

4. **Android Signing**:
   - Check keystore configuration
   - Verify signing keys
   - Ensure proper permissions

### Support Resources
- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 📞 Contact

For deployment issues or questions:
- Create GitHub issue
- Check documentation
- Contact development team

---

**Ready to deploy!** 🚀 Follow these steps to get your Portfolio Tracker app running on mobile devices and GitHub.
