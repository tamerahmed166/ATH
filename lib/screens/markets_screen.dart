import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_tracker/providers/portfolio_provider.dart';
import 'package:portfolio_tracker/models/asset.dart';
import 'package:portfolio_tracker/widgets/asset_search_card.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<Asset> _popularAssets = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadPopularAssets();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPopularAssets() async {
    // In a real app, you would load from API
    // For now, we'll use mock data
    setState(() {
      _popularAssets = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markets'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Stocks'),
            Tab(text: 'Crypto'),
            Tab(text: 'Commodities'),
            Tab(text: 'Forex'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search assets...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<PortfolioProvider>().searchAssets(value);
                }
              },
            ),
          ),
          
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAssetList(AssetType.stock),
                _buildAssetList(AssetType.crypto),
                _buildAssetList(AssetType.commodity),
                _buildAssetList(AssetType.currency),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetList(AssetType type) {
    return Consumer<PortfolioProvider>(
      builder: (context, portfolioProvider, child) {
        if (portfolioProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final assets = portfolioProvider.searchQuery.isNotEmpty
            ? portfolioProvider.searchResults
            : _getPopularAssetsByType(type);

        if (assets.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getTypeIcon(type),
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No ${type.name} assets found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: assets.length,
          itemBuilder: (context, index) {
            final asset = assets[index];
            final isInPortfolio = portfolioProvider.portfolio
                .any((a) => a.symbol == asset.symbol);

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AssetSearchCard(
                asset: asset,
                isInPortfolio: isInPortfolio,
                onAdd: () => _addAsset(context, asset),
                onRemove: () => _removeAsset(context, asset.symbol),
              ),
            );
          },
        );
      },
    );
  }

  List<Asset> _getPopularAssetsByType(AssetType type) {
    // Mock data for popular assets
    switch (type) {
      case AssetType.stock:
        return [
          Asset(
            id: 'AAPL',
            symbol: 'AAPL',
            name: 'Apple Inc.',
            type: AssetType.stock,
            currentPrice: 172.10,
            dayChange: -2.35,
            dayChangePercent: -1.35,
            allTimeHigh: 182.94,
          ),
          Asset(
            id: 'GOOGL',
            symbol: 'GOOGL',
            name: 'Alphabet Inc.',
            type: AssetType.stock,
            currentPrice: 142.50,
            dayChange: 1.20,
            dayChangePercent: 0.85,
            allTimeHigh: 151.55,
          ),
          Asset(
            id: 'MSFT',
            symbol: 'MSFT',
            name: 'Microsoft Corporation',
            type: AssetType.stock,
            currentPrice: 378.85,
            dayChange: -0.95,
            dayChangePercent: -0.25,
            allTimeHigh: 384.30,
          ),
        ];
      case AssetType.crypto:
        return [
          Asset(
            id: 'BTC-USD',
            symbol: 'BTC-USD',
            name: 'Bitcoin',
            type: AssetType.crypto,
            currentPrice: 43250.00,
            dayChange: 1250.00,
            dayChangePercent: 2.98,
            allTimeHigh: 69000.00,
          ),
          Asset(
            id: 'ETH-USD',
            symbol: 'ETH-USD',
            name: 'Ethereum',
            type: AssetType.crypto,
            currentPrice: 2650.00,
            dayChange: 45.00,
            dayChangePercent: 1.73,
            allTimeHigh: 4878.26,
          ),
        ];
      case AssetType.commodity:
        return [
          Asset(
            id: 'CL=F',
            symbol: 'CL=F',
            name: 'Crude Oil',
            type: AssetType.commodity,
            currentPrice: 72.17,
            dayChange: 0.30,
            dayChangePercent: 0.42,
            allTimeHigh: 147.27,
          ),
          Asset(
            id: 'GC=F',
            symbol: 'GC=F',
            name: 'Gold',
            type: AssetType.commodity,
            currentPrice: 1950.47,
            dayChange: -4.90,
            dayChangePercent: -0.25,
            allTimeHigh: 2075.20,
          ),
        ];
      case AssetType.currency:
        return [
          Asset(
            id: 'EURUSD=X',
            symbol: 'EURUSD=X',
            name: 'EUR/USD',
            type: AssetType.currency,
            currentPrice: 1.12,
            dayChange: 0.0016,
            dayChangePercent: 0.14,
            allTimeHigh: 1.60,
          ),
          Asset(
            id: 'GBPUSD=X',
            symbol: 'GBPUSD=X',
            name: 'GBP/USD',
            type: AssetType.currency,
            currentPrice: 1.28,
            dayChange: -0.002,
            dayChangePercent: -0.16,
            allTimeHigh: 2.11,
          ),
        ];
    }
  }

  IconData _getTypeIcon(AssetType type) {
    switch (type) {
      case AssetType.stock:
        return Icons.trending_up;
      case AssetType.crypto:
        return Icons.currency_bitcoin;
      case AssetType.commodity:
        return Icons.local_gas_station;
      case AssetType.currency:
        return Icons.attach_money;
    }
  }

  void _addAsset(BuildContext context, Asset asset) {
    context.read<PortfolioProvider>().addAsset(asset);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${asset.symbol} added to portfolio'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _removeAsset(BuildContext context, String symbol) {
    context.read<PortfolioProvider>().removeAsset(symbol);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$symbol removed from portfolio'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
