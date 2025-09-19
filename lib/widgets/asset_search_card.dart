import 'package:flutter/material.dart';
import 'package:portfolio_tracker/models/asset.dart';

class AssetSearchCard extends StatelessWidget {
  final Asset asset;
  final bool isInPortfolio;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const AssetSearchCard({
    super.key,
    required this.asset,
    required this.isInPortfolio,
    this.onAdd,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Asset Icon
            CircleAvatar(
              backgroundColor: _getAssetColor(asset.type),
              radius: 20,
              child: Text(
                asset.symbol.substring(0, 1),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Asset Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset.symbol,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    asset.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Price Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${asset.currentPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (asset.dayChangePercent != null)
                  Text(
                    '${asset.dayChangePercent! >= 0 ? '+' : ''}${asset.dayChangePercent!.toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 12,
                      color: asset.dayChangePercent! >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
              ],
            ),
            
            // Action Button
            const SizedBox(width: 12),
            if (isInPortfolio)
              IconButton(
                onPressed: onRemove,
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                tooltip: 'Remove from portfolio',
              )
            else
              IconButton(
                onPressed: onAdd,
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                tooltip: 'Add to portfolio',
              ),
          ],
        ),
      ),
    );
  }

  Color _getAssetColor(AssetType type) {
    switch (type) {
      case AssetType.stock:
        return Colors.blue;
      case AssetType.crypto:
        return Colors.orange;
      case AssetType.commodity:
        return Colors.amber;
      case AssetType.currency:
        return Colors.purple;
    }
  }
}
