import 'package:flutter/foundation.dart';
import 'package:portfolio_tracker/models/asset.dart';
import 'package:portfolio_tracker/services/api_service.dart';

class PortfolioProvider with ChangeNotifier {
  List<Asset> _portfolio = [];
  List<Asset> _searchResults = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Asset> get portfolio => _portfolio;
  List<Asset> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  double get totalValue {
    return _portfolio.fold(0.0, (sum, asset) => sum + asset.currentPrice);
  }

  double get totalDayChange {
    return _portfolio.fold(0.0, (sum, asset) => sum + (asset.dayChange ?? 0));
  }

  double get totalDayChangePercent {
    if (totalValue == 0) return 0;
    return (totalDayChange / totalValue) * 100;
  }

  List<Asset> get assetsAtATH {
    return _portfolio.where((asset) => asset.isAtAllTimeHigh).toList();
  }

  Future<void> loadPortfolio() async {
    _setLoading(true);
    try {
      // In a real app, you would load from Firestore
      // For now, we'll load some popular assets
      final assets = await ApiService.getPopularAssets();
      _portfolio = assets;
      notifyListeners();
    } catch (e) {
      print('Error loading portfolio: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshPortfolio() async {
    if (_portfolio.isEmpty) return;
    
    _setLoading(true);
    try {
      final symbols = _portfolio.map((asset) => asset.symbol).toList();
      final updatedAssets = await ApiService.getMultipleAssetPrices(symbols);
      
      // Update existing assets with new prices
      for (int i = 0; i < _portfolio.length; i++) {
        final updatedAsset = updatedAssets.firstWhere(
          (asset) => asset.symbol == _portfolio[i].symbol,
          orElse: () => _portfolio[i],
        );
        _portfolio[i] = updatedAsset;
      }
      
      notifyListeners();
    } catch (e) {
      print('Error refreshing portfolio: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> searchAssets(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      _searchQuery = '';
      notifyListeners();
      return;
    }

    _searchQuery = query;
    _setLoading(true);
    
    try {
      final results = await ApiService.searchAssets(query);
      _searchResults = results;
    } catch (e) {
      print('Error searching assets: $e');
      _searchResults = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addAsset(Asset asset) async {
    if (_portfolio.any((a) => a.symbol == asset.symbol)) {
      return; // Asset already exists
    }

    try {
      // Fetch current price for the asset
      final updatedAsset = await ApiService.getAssetPrice(asset.symbol);
      if (updatedAsset != null) {
        _portfolio.add(updatedAsset);
        notifyListeners();
        
        // In a real app, save to Firestore
        // await _saveToFirestore(updatedAsset);
      }
    } catch (e) {
      print('Error adding asset: $e');
    }
  }

  Future<void> removeAsset(String symbol) async {
    _portfolio.removeWhere((asset) => asset.symbol == symbol);
    notifyListeners();
    
    // In a real app, remove from Firestore
    // await _removeFromFirestore(symbol);
  }

  Asset? getAssetBySymbol(String symbol) {
    try {
      return _portfolio.firstWhere((asset) => asset.symbol == symbol);
    } catch (e) {
      return null;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Auto-refresh every minute
  void startAutoRefresh() {
    Future.delayed(const Duration(minutes: 1), () {
      if (_portfolio.isNotEmpty) {
        refreshPortfolio();
        startAutoRefresh(); // Schedule next refresh
      }
    });
  }
}
