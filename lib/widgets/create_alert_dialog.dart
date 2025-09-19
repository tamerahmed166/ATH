import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_tracker/providers/portfolio_provider.dart';
import 'package:portfolio_tracker/models/alert.dart';
import 'package:portfolio_tracker/models/asset.dart';

class CreateAlertDialog extends StatefulWidget {
  final Function(String assetId, String assetSymbol) onATHAlert;
  final Function(String assetId, String assetSymbol, AlertType type, double targetPrice) onPriceAlert;

  const CreateAlertDialog({
    super.key,
    required this.onATHAlert,
    required this.onPriceAlert,
  });

  @override
  State<CreateAlertDialog> createState() => _CreateAlertDialogState();
}

class _CreateAlertDialogState extends State<CreateAlertDialog> {
  Asset? _selectedAsset;
  AlertType _alertType = AlertType.ath;
  final TextEditingController _priceController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Alert'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Asset Selection
            DropdownButtonFormField<Asset>(
              value: _selectedAsset,
              decoration: const InputDecoration(
                labelText: 'Select Asset',
                border: OutlineInputBorder(),
              ),
              items: context.read<PortfolioProvider>().portfolio.map((asset) {
                return DropdownMenuItem<Asset>(
                  value: asset,
                  child: Text('${asset.symbol} - ${asset.name}'),
                );
              }).toList(),
              onChanged: (asset) {
                setState(() {
                  _selectedAsset = asset;
                });
              },
            ),
            
            if (_selectedAsset != null) ...[
              const SizedBox(height: 16),
              
              // Alert Type Selection
              DropdownButtonFormField<AlertType>(
                value: _alertType,
                decoration: const InputDecoration(
                  labelText: 'Alert Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: AlertType.ath,
                    child: Text('All Time High'),
                  ),
                  DropdownMenuItem(
                    value: AlertType.priceAbove,
                    child: Text('Price Above'),
                  ),
                  DropdownMenuItem(
                    value: AlertType.priceBelow,
                    child: Text('Price Below'),
                  ),
                ],
                onChanged: (type) {
                  setState(() {
                    _alertType = type!;
                  });
                },
              ),
              
              // Price Input (for price alerts)
              if (_alertType == AlertType.priceAbove || _alertType == AlertType.priceBelow) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Target Price',
                    prefixText: '\$',
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _selectedAsset != null ? _createAlert : null,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }

  void _createAlert() {
    if (_selectedAsset == null) return;

    setState(() {
      _isLoading = true;
    });

    if (_alertType == AlertType.ath) {
      widget.onATHAlert(_selectedAsset!.id, _selectedAsset!.symbol);
    } else {
      final targetPrice = double.tryParse(_priceController.text);
      if (targetPrice == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid price'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      widget.onPriceAlert(
        _selectedAsset!.id,
        _selectedAsset!.symbol,
        _alertType,
        targetPrice,
      );
    }
  }
}
