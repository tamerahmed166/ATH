import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:portfolio_tracker/models/asset.dart';
import 'package:portfolio_tracker/models/alert.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // Initialize local notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions
    await _requestPermissions();
    
    // Configure Firebase messaging
    await _configureFirebaseMessaging();
  }

  static Future<void> _requestPermissions() async {
    // Android 13+ permission
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // iOS permission
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> _configureFirebaseMessaging() async {
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Handle notification taps
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
  }

  static Future<void> _onNotificationTapped(NotificationResponse response) async {
    // Handle local notification tap
    print('Notification tapped: ${response.payload}');
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    // Show local notification when app is in foreground
    await showLocalNotification(
      title: message.notification?.title ?? 'Portfolio Alert',
      body: message.notification?.body ?? '',
      payload: message.data['assetId'],
    );
  }

  static Future<void> _handleNotificationTap(RemoteMessage message) async {
    // Handle notification tap when app was in background
    print('Notification tapped: ${message.data}');
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'portfolio_alerts',
      'Portfolio Alerts',
      channelDescription: 'Notifications for portfolio alerts',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }

  static Future<void> showATHAlert(Asset asset) async {
    await showLocalNotification(
      title: '🎉 All Time High!',
      body: '${asset.symbol} has reached a new all-time high of \$${asset.currentPrice.toStringAsFixed(2)}!',
      payload: asset.id,
    );
  }

  static Future<void> showPriceAlert(Alert alert, Asset asset) async {
    String title = '📈 Price Alert';
    String body = '';
    
    switch (alert.type) {
      case AlertType.priceAbove:
        title = '📈 Price Above Target';
        body = '${asset.symbol} is now above \$${alert.targetPrice?.toStringAsFixed(2)} at \$${asset.currentPrice.toStringAsFixed(2)}';
        break;
      case AlertType.priceBelow:
        title = '📉 Price Below Target';
        body = '${asset.symbol} is now below \$${alert.targetPrice?.toStringAsFixed(2)} at \$${asset.currentPrice.toStringAsFixed(2)}';
        break;
      case AlertType.percentageChange:
        title = '📊 Percentage Change Alert';
        body = '${asset.symbol} has changed by ${alert.targetPercentage?.toStringAsFixed(1)}% to \$${asset.currentPrice.toStringAsFixed(2)}';
        break;
      case AlertType.ath:
        title = '🎉 All Time High!';
        body = '${asset.symbol} has reached a new all-time high of \$${asset.currentPrice.toStringAsFixed(2)}!';
        break;
    }
    
    await showLocalNotification(
      title: title,
      body: body,
      payload: asset.id,
    );
  }

  static Future<String?> getFCMToken() async {
    return await _messaging.getToken();
  }

  static Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }
}

// Background message handler (must be top-level function)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.messageId}');
}
