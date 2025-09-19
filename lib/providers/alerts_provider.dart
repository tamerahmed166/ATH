import 'package:flutter/foundation.dart';
import 'package:portfolio_tracker/models/alert.dart';
import 'package:portfolio_tracker/models/asset.dart';
import 'package:portfolio_tracker/services/notification_service.dart';

class AlertsProvider with ChangeNotifier {
  List<Alert> _alerts = [];
  bool _isLoading = false;

  List<Alert> get alerts => _alerts;
  bool get isLoading => _isLoading;

  List<Alert> get activeAlerts {
    return _alerts.where((alert) => alert.status == AlertStatus.active).toList();
  }

  List<Alert> get triggeredAlerts {
    return _alerts.where((alert) => alert.status == AlertStatus.triggered).toList();
  }

  Future<void> loadAlerts() async {
    _setLoading(true);
    try {
      // In a real app, load from Firestore
      // For now, we'll use mock data
      _alerts = [];
      notifyListeners();
    } catch (e) {
      print('Error loading alerts: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createATHAlert(String assetId, String assetSymbol) async {
    final alert = Alert(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      assetId: assetId,
      assetSymbol: assetSymbol,
      type: AlertType.ath,
      createdAt: DateTime.now(),
    );

    _alerts.add(alert);
    notifyListeners();
    
    // In a real app, save to Firestore
    // await _saveToFirestore(alert);
  }

  Future<void> createPriceAlert({
    required String assetId,
    required String assetSymbol,
    required AlertType type,
    required double targetPrice,
    bool isPushEnabled = true,
    bool isEmailEnabled = false,
    String? email,
  }) async {
    final alert = Alert(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      assetId: assetId,
      assetSymbol: assetSymbol,
      type: type,
      targetPrice: targetPrice,
      createdAt: DateTime.now(),
      isPushEnabled: isPushEnabled,
      isEmailEnabled: isEmailEnabled,
      email: email,
    );

    _alerts.add(alert);
    notifyListeners();
    
    // In a real app, save to Firestore
    // await _saveToFirestore(alert);
  }

  Future<void> createPercentageAlert({
    required String assetId,
    required String assetSymbol,
    required double targetPercentage,
    bool isPushEnabled = true,
    bool isEmailEnabled = false,
    String? email,
  }) async {
    final alert = Alert(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      assetId: assetId,
      assetSymbol: assetSymbol,
      type: AlertType.percentageChange,
      targetPercentage: targetPercentage,
      createdAt: DateTime.now(),
      isPushEnabled: isPushEnabled,
      isEmailEnabled: isEmailEnabled,
      email: email,
    );

    _alerts.add(alert);
    notifyListeners();
    
    // In a real app, save to Firestore
    // await _saveToFirestore(alert);
  }

  Future<void> toggleAlert(String alertId) async {
    final index = _alerts.indexWhere((alert) => alert.id == alertId);
    if (index != -1) {
      final alert = _alerts[index];
      final newStatus = alert.status == AlertStatus.active 
          ? AlertStatus.inactive 
          : AlertStatus.active;
      
      _alerts[index] = alert.copyWith(status: newStatus);
      notifyListeners();
      
      // In a real app, update in Firestore
      // await _updateInFirestore(_alerts[index]);
    }
  }

  Future<void> deleteAlert(String alertId) async {
    _alerts.removeWhere((alert) => alert.id == alertId);
    notifyListeners();
    
    // In a real app, delete from Firestore
    // await _deleteFromFirestore(alertId);
  }

  Future<void> checkAlerts(List<Asset> assets) async {
    for (final asset in assets) {
      final assetAlerts = _alerts.where((alert) => 
          alert.assetId == asset.id && 
          alert.status == AlertStatus.active
      ).toList();

      for (final alert in assetAlerts) {
        bool shouldTrigger = false;

        switch (alert.type) {
          case AlertType.ath:
            shouldTrigger = asset.isAtAllTimeHigh;
            break;
          case AlertType.priceAbove:
            shouldTrigger = alert.targetPrice != null && 
                asset.currentPrice >= alert.targetPrice!;
            break;
          case AlertType.priceBelow:
            shouldTrigger = alert.targetPrice != null && 
                asset.currentPrice <= alert.targetPrice!;
            break;
          case AlertType.percentageChange:
            if (alert.targetPercentage != null && asset.dayChangePercent != null) {
              shouldTrigger = asset.dayChangePercent! >= alert.targetPercentage!;
            }
            break;
        }

        if (shouldTrigger) {
          await _triggerAlert(alert, asset);
        }
      }
    }
  }

  Future<void> _triggerAlert(Alert alert, Asset asset) async {
    // Mark alert as triggered
    final index = _alerts.indexWhere((a) => a.id == alert.id);
    if (index != -1) {
      _alerts[index] = alert.copyWith(
        status: AlertStatus.triggered,
        triggeredAt: DateTime.now(),
      );
      notifyListeners();
    }

    // Send notification
    if (alert.isPushEnabled) {
      if (alert.type == AlertType.ath) {
        await NotificationService.showATHAlert(asset);
      } else {
        await NotificationService.showPriceAlert(alert, asset);
      }
    }

    // In a real app, send email if enabled
    if (alert.isEmailEnabled && alert.email != null) {
      // Send email notification
      print('Sending email to ${alert.email} for ${alert.description}');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
