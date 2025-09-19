import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portfolio_tracker/models/asset.dart';

class ApiService {
  static const String _baseUrl = 'https://query1.finance.yahoo.com/v8/finance/chart';
  static const String _searchUrl = 'https://query1.finance.yahoo.com/v1/finance/search';
  
  // Popular assets for quick access
  static const Map<String, Map<String, dynamic>> _popularAssets = {
    'AAPL': {'name': 'Apple Inc.', 'type': 'stock'},
    'GOOGL': {'name': 'Alphabet Inc.', 'type': 'stock'},
    'MSFT': {'name': 'Microsoft Corporation', 'type': 'stock'},
    'TSLA': {'name': 'Tesla, Inc.', 'type': 'stock'},
    'AMZN': {'name': 'Amazon.com, Inc.', 'type': 'stock'},
    'NVDA': {'name': 'NVIDIA Corporation', 'type': 'stock'},
    'META': {'name': 'Meta Platforms, Inc.', 'type': 'stock'},
    'BTC-USD': {'name': 'Bitcoin', 'type': 'crypto'},
    'ETH-USD': {'name': 'Ethereum', 'type': 'crypto'},
    'CL=F': {'name': 'Crude Oil', 'type': 'commodity'},
    'GC=F': {'name': 'Gold', 'type': 'commodity'},
    'EURUSD=X': {'name': 'EUR/USD', 'type': 'currency'},
    'GBPUSD=X': {'name': 'GBP/USD', 'type': 'currency'},
    'USDJPY=X': {'name': 'USD/JPY', 'type': 'currency'},
  };

  static Future<List<Asset>> searchAssets(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_searchUrl?q=$query&quotesCount=10'),
        headers: {'User-Agent': 'Mozilla/5.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final quotes = data['quotes'] as List<dynamic>? ?? [];
        
        return quotes.map((quote) {
          final symbol = quote['symbol'] as String? ?? '';
          final shortName = quote['shortName'] as String? ?? '';
          final longName = quote['longName'] as String? ?? '';
          final exchange = quote['exchange'] as String? ?? '';
          
          return Asset(
            id: symbol,
            symbol: symbol,
            name: longName.isNotEmpty ? longName : shortName,
            type: _getAssetType(symbol, exchange),
            currentPrice: 0.0,
            currency: _getCurrency(symbol),
          );
        }).toList();
      }
    } catch (e) {
      print('Error searching assets: $e');
    }
    
    return [];
  }

  static Future<List<Asset>> getPopularAssets() async {
    List<Asset> assets = [];
    
    for (final entry in _popularAssets.entries) {
      final symbol = entry.key;
      final info = entry.value;
      
      try {
        final asset = await getAssetPrice(symbol);
        if (asset != null) {
          assets.add(asset.copyWith(
            name: info['name'],
            type: _getAssetType(symbol, ''),
          ));
        }
      } catch (e) {
        print('Error fetching $symbol: $e');
      }
    }
    
    return assets;
  }

  static Future<Asset?> getAssetPrice(String symbol) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$symbol'),
        headers: {'User-Agent': 'Mozilla/5.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final chart = data['chart'];
        final result = chart['result'] as List<dynamic>?;
        
        if (result != null && result.isNotEmpty) {
          final meta = result[0]['meta'] as Map<String, dynamic>;
          final quote = result[0]['indicators']['quote'][0] as Map<String, dynamic>;
          
          final currentPrice = meta['regularMarketPrice']?.toDouble() ?? 0.0;
          final previousClose = meta['previousClose']?.toDouble();
          final dayChange = currentPrice - (previousClose ?? currentPrice);
          final dayChangePercent = previousClose != null 
              ? (dayChange / previousClose) * 100 
              : 0.0;
          
          return Asset(
            id: symbol,
            symbol: symbol,
            name: meta['longName'] ?? symbol,
            type: _getAssetType(symbol, meta['exchange'] ?? ''),
            currentPrice: currentPrice,
            previousClose: previousClose,
            dayChange: dayChange,
            dayChangePercent: dayChangePercent,
            allTimeHigh: meta['fiftyTwoWeekHigh']?.toDouble(),
            lastUpdated: DateTime.now(),
            currency: _getCurrency(symbol),
          );
        }
      }
    } catch (e) {
      print('Error fetching price for $symbol: $e');
    }
    
    return null;
  }

  static Future<List<Asset>> getMultipleAssetPrices(List<String> symbols) async {
    List<Asset> assets = [];
    
    for (final symbol in symbols) {
      try {
        final asset = await getAssetPrice(symbol);
        if (asset != null) {
          assets.add(asset);
        }
      } catch (e) {
        print('Error fetching $symbol: $e');
      }
    }
    
    return assets;
  }

  static AssetType _getAssetType(String symbol, String exchange) {
    if (symbol.contains('BTC') || symbol.contains('ETH') || symbol.contains('crypto')) {
      return AssetType.crypto;
    } else if (symbol.contains('=X') || symbol.contains('USD') || symbol.contains('EUR')) {
      return AssetType.currency;
    } else if (symbol.contains('=F') || symbol.contains('Oil') || symbol.contains('Gold')) {
      return AssetType.commodity;
    } else {
      return AssetType.stock;
    }
  }

  static String? _getCurrency(String symbol) {
    if (symbol.contains('USD')) return 'USD';
    if (symbol.contains('EUR')) return 'EUR';
    if (symbol.contains('GBP')) return 'GBP';
    if (symbol.contains('JPY')) return 'JPY';
    return 'USD';
  }
}
