import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_tracker/providers/portfolio_provider.dart';
import 'package:portfolio_tracker/providers/alerts_provider.dart';
import 'package:portfolio_tracker/widgets/asset_card.dart';
import 'package:portfolio_tracker/widgets/portfolio_summary.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PortfolioProvider>().loadPortfolio();
      context.read<AlertsProvider>().loadAlerts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<PortfolioProvider>().refreshPortfolio();
            },
          ),
        ],
      ),
      body: Consumer<PortfolioProvider>(
        builder: (context, portfolioProvider, child) {
          if (portfolioProvider.isLoading && portfolioProvider.portfolio.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (portfolioProvider.portfolio.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.portfolio,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No assets in your portfolio',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Go to Markets tab to add assets',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await portfolioProvider.refreshPortfolio();
            },
            child: Column(
              children: [
                PortfolioSummary(
                  totalValue: portfolioProvider.totalValue,
                  totalDayChange: portfolioProvider.totalDayChange,
                  totalDayChangePercent: portfolioProvider.totalDayChangePercent,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: portfolioProvider.portfolio.length,
                    itemBuilder: (context, index) {
                      final asset = portfolioProvider.portfolio[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AssetCard(
                          asset: asset,
                          onTap: () => _showAssetDetails(context, asset),
                          onRemove: () => _removeAsset(context, asset.symbol),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAssetDetails(BuildContext context, asset) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: Text(
                      asset.symbol.substring(0, 1),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          asset.symbol,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          asset.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Price',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '\$${asset.currentPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (asset.dayChange != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${asset.dayChange! > 0 ? '+' : ''}\$${asset.dayChange!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: asset.dayChange! > 0 ? Colors.green : Colors.red,
                          ),
                        ),
                        if (asset.dayChangePercent != null)
                          Text(
                            '${asset.dayChangePercent! > 0 ? '+' : ''}${asset.dayChangePercent!.toStringAsFixed(2)}%',
                            style: TextStyle(
                              fontSize: 14,
                              color: asset.dayChangePercent! > 0 ? Colors.green : Colors.red,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 24),
              if (asset.allTimeHigh != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: asset.isAtAllTimeHigh ? Colors.green[50] : Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: asset.isAtAllTimeHigh ? Colors.green : Colors.blue,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        asset.isAtAllTimeHigh ? Icons.trending_up : Icons.history,
                        color: asset.isAtAllTimeHigh ? Colors.green : Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              asset.isAtAllTimeHigh ? 'All Time High!' : 'All Time High',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: asset.isAtAllTimeHigh ? Colors.green : Colors.blue,
                              ),
                            ),
                            Text(
                              '\$${asset.allTimeHigh!.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: asset.isAtAllTimeHigh ? Colors.green : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<AlertsProvider>().createATHAlert(asset.id, asset.symbol);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('ATH alert created for ${asset.symbol}'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.notifications),
                  label: const Text('Create ATH Alert'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeAsset(BuildContext context, String symbol) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Asset'),
        content: Text('Are you sure you want to remove $symbol from your portfolio?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<PortfolioProvider>().removeAsset(symbol);
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
