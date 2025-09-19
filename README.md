# Portfolio Tracker

A simple Flutter application focused on tracking portfolio assets and ATH (All Time High) alerts for stocks, oil, gold, and currencies.

## Features

### Core Features (MVP)
- **Asset Management**: Add and track stocks, crypto, commodities, and currencies
- **Real-time Prices**: Live price updates from Yahoo Finance API
- **ATH Alerts**: Push notifications when assets reach all-time highs
- **Custom Price Alerts**: Set alerts for specific price levels
- **Portfolio Overview**: Track total portfolio value and daily changes

### User Interface
- **Portfolio Tab**: Main dashboard with asset list and portfolio summary
- **Markets Tab**: Browse and add assets by category (Stocks, Crypto, Commodities, Forex)
- **Alerts Tab**: Manage active and triggered alerts

## Technology Stack

- **Frontend**: Flutter (Cross-platform mobile)
- **Backend**: Firebase (Authentication, Firestore, Cloud Functions)
- **Data APIs**: Yahoo Finance API for real-time prices
- **Notifications**: Firebase Cloud Messaging + Local notifications

## Setup Instructions

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Android Studio / Xcode
- Firebase project

### 1. Clone and Install Dependencies
```bash
git clone <repository-url>
cd portfolio_tracker
flutter pub get
```

### 2. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project named "Portfolio Tracker"
3. Enable Authentication, Firestore Database, and Cloud Messaging

#### Android Setup
1. Add Android app to Firebase project
2. Download `google-services.json` and place in `android/app/`
3. Update `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'
```

#### iOS Setup
1. Add iOS app to Firebase project
2. Download `GoogleService-Info.plist` and place in `ios/Runner/`
3. Update `ios/Runner/Info.plist` with notification permissions

### 3. API Configuration
The app uses Yahoo Finance API for real-time data. No API key required for basic usage.

### 4. Run the Application
```bash
# For Android
flutter run

# For iOS
flutter run -d ios
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                  # Data models
│   ├── asset.dart          # Asset model
│   └── alert.dart          # Alert model
├── providers/              # State management
│   ├── portfolio_provider.dart
│   └── alerts_provider.dart
├── screens/                # UI screens
│   ├── main_screen.dart    # Bottom navigation
│   ├── portfolio_screen.dart
│   ├── markets_screen.dart
│   └── alerts_screen.dart
├── services/               # API and services
│   ├── api_service.dart    # Yahoo Finance API
│   └── notification_service.dart
└── widgets/                # Reusable widgets
    ├── asset_card.dart
    ├── portfolio_summary.dart
    └── alert_card.dart
```

## Key Features Implementation

### Real-time Price Updates
- Yahoo Finance API integration
- Auto-refresh every minute
- Manual refresh capability

### ATH Detection
- Compares current price with 52-week high
- Visual indicators for ATH assets
- Automatic alert triggering

### Push Notifications
- Local notifications for immediate alerts
- Firebase Cloud Messaging for background alerts
- Custom notification sounds and icons

### Portfolio Management
- Add/remove assets
- Real-time portfolio value calculation
- Daily change tracking
- Asset categorization

## Future Enhancements

### Phase 2 Features
- **Advanced Statistics**: 24h, 7d, 1y performance metrics
- **Technical Analysis**: RSI, Moving Averages
- **News Integration**: Asset-related news feed
- **Export Functionality**: PDF/Excel portfolio reports

### Phase 3 Features
- **Social Features**: Share portfolio performance
- **Advanced Alerts**: Percentage change alerts, volume alerts
- **Portfolio Analytics**: Risk analysis, diversification metrics
- **Dark Mode**: Theme customization

## Development Notes

### State Management
- Uses Provider pattern for state management
- Separate providers for portfolio and alerts
- Reactive UI updates

### API Integration
- Yahoo Finance API for real-time data
- Error handling and retry logic
- Caching for offline functionality

### Notification System
- Local notifications for immediate feedback
- Firebase Cloud Messaging for background alerts
- Notification scheduling and management

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions:
- Create an issue in the repository
- Check the documentation
- Contact the development team

---

**Note**: This is an MVP (Minimum Viable Product) focused on core ATH alert functionality. Additional features will be added in future releases.
