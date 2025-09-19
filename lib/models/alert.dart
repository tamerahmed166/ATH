import 'package:cloud_firestore/cloud_firestore.dart';

enum AlertType { ath, priceAbove, priceBelow, percentageChange }

enum AlertStatus { active, inactive, triggered }

class Alert {
  final String id;
  final String assetId;
  final String assetSymbol;
  final AlertType type;
  final double? targetPrice;
  final double? targetPercentage;
  final AlertStatus status;
  final DateTime createdAt;
  final DateTime? triggeredAt;
  final bool isPushEnabled;
  final bool isEmailEnabled;
  final String? email;

  Alert({
    required this.id,
    required this.assetId,
    required this.assetSymbol,
    required this.type,
    this.targetPrice,
    this.targetPercentage,
    this.status = AlertStatus.active,
    required this.createdAt,
    this.triggeredAt,
    this.isPushEnabled = true,
    this.isEmailEnabled = false,
    this.email,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'] ?? '',
      assetId: json['assetId'] ?? '',
      assetSymbol: json['assetSymbol'] ?? '',
      type: AlertType.values.firstWhere(
        (e) => e.toString() == 'AlertType.${json['type']}',
        orElse: () => AlertType.ath,
      ),
      targetPrice: json['targetPrice']?.toDouble(),
      targetPercentage: json['targetPercentage']?.toDouble(),
      status: AlertStatus.values.firstWhere(
        (e) => e.toString() == 'AlertStatus.${json['status']}',
        orElse: () => AlertStatus.active,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] ?? 0),
      triggeredAt: json['triggeredAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['triggeredAt'])
          : null,
      isPushEnabled: json['isPushEnabled'] ?? true,
      isEmailEnabled: json['isEmailEnabled'] ?? false,
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assetId': assetId,
      'assetSymbol': assetSymbol,
      'type': type.toString().split('.').last,
      'targetPrice': targetPrice,
      'targetPercentage': targetPercentage,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'triggeredAt': triggeredAt?.millisecondsSinceEpoch,
      'isPushEnabled': isPushEnabled,
      'isEmailEnabled': isEmailEnabled,
      'email': email,
    };
  }

  Alert copyWith({
    String? id,
    String? assetId,
    String? assetSymbol,
    AlertType? type,
    double? targetPrice,
    double? targetPercentage,
    AlertStatus? status,
    DateTime? createdAt,
    DateTime? triggeredAt,
    bool? isPushEnabled,
    bool? isEmailEnabled,
    String? email,
  }) {
    return Alert(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      assetSymbol: assetSymbol ?? this.assetSymbol,
      type: type ?? this.type,
      targetPrice: targetPrice ?? this.targetPrice,
      targetPercentage: targetPercentage ?? this.targetPercentage,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      triggeredAt: triggeredAt ?? this.triggeredAt,
      isPushEnabled: isPushEnabled ?? this.isPushEnabled,
      isEmailEnabled: isEmailEnabled ?? this.isEmailEnabled,
      email: email ?? this.email,
    );
  }

  String get description {
    switch (type) {
      case AlertType.ath:
        return '$assetSymbol All Time High';
      case AlertType.priceAbove:
        return '$assetSymbol above \$${targetPrice?.toStringAsFixed(2)}';
      case AlertType.priceBelow:
        return '$assetSymbol below \$${targetPrice?.toStringAsFixed(2)}';
      case AlertType.percentageChange:
        return '$assetSymbol ${targetPercentage! > 0 ? '+' : ''}${targetPercentage?.toStringAsFixed(1)}%';
    }
  }
}
