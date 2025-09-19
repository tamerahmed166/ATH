import 'package:cloud_firestore/cloud_firestore.dart';

enum AssetType { stock, crypto, commodity, currency }

class Asset {
  final String id;
  final String symbol;
  final String name;
  final AssetType type;
  final String? iconUrl;
  final double currentPrice;
  final double? previousClose;
  final double? dayChange;
  final double? dayChangePercent;
  final double? allTimeHigh;
  final DateTime? lastUpdated;
  final String? currency;

  Asset({
    required this.id,
    required this.symbol,
    required this.name,
    required this.type,
    this.iconUrl,
    required this.currentPrice,
    this.previousClose,
    this.dayChange,
    this.dayChangePercent,
    this.allTimeHigh,
    this.lastUpdated,
    this.currency,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      type: AssetType.values.firstWhere(
        (e) => e.toString() == 'AssetType.${json['type']}',
        orElse: () => AssetType.stock,
      ),
      iconUrl: json['iconUrl'],
      currentPrice: (json['currentPrice'] ?? 0).toDouble(),
      previousClose: json['previousClose']?.toDouble(),
      dayChange: json['dayChange']?.toDouble(),
      dayChangePercent: json['dayChangePercent']?.toDouble(),
      allTimeHigh: json['allTimeHigh']?.toDouble(),
      lastUpdated: json['lastUpdated'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['lastUpdated'])
          : null,
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'type': type.toString().split('.').last,
      'iconUrl': iconUrl,
      'currentPrice': currentPrice,
      'previousClose': previousClose,
      'dayChange': dayChange,
      'dayChangePercent': dayChangePercent,
      'allTimeHigh': allTimeHigh,
      'lastUpdated': lastUpdated?.millisecondsSinceEpoch,
      'currency': currency,
    };
  }

  Asset copyWith({
    String? id,
    String? symbol,
    String? name,
    AssetType? type,
    String? iconUrl,
    double? currentPrice,
    double? previousClose,
    double? dayChange,
    double? dayChangePercent,
    double? allTimeHigh,
    DateTime? lastUpdated,
    String? currency,
  }) {
    return Asset(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      type: type ?? this.type,
      iconUrl: iconUrl ?? this.iconUrl,
      currentPrice: currentPrice ?? this.currentPrice,
      previousClose: previousClose ?? this.previousClose,
      dayChange: dayChange ?? this.dayChange,
      dayChangePercent: dayChangePercent ?? this.dayChangePercent,
      allTimeHigh: allTimeHigh ?? this.allTimeHigh,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      currency: currency ?? this.currency,
    );
  }

  bool get isAtAllTimeHigh {
    return allTimeHigh != null && currentPrice >= allTimeHigh!;
  }

  double? get distanceFromATH {
    if (allTimeHigh == null) return null;
    return ((currentPrice - allTimeHigh!) / allTimeHigh!) * 100;
  }
}
