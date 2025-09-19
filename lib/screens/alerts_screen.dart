import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_tracker/providers/alerts_provider.dart';
import 'package:portfolio_tracker/providers/portfolio_provider.dart';
import 'package:portfolio_tracker/models/alert.dart';
import 'package:portfolio_tracker/widgets/alert_card.dart';
import 'package:portfolio_tracker/widgets/create_alert_dialog.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateAlertDialog(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Triggered'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveAlerts(),
          _buildTriggeredAlerts(),
        ],
      ),
    );
  }

  Widget _buildActiveAlerts() {
    return Consumer<AlertsProvider>(
      builder: (context, alertsProvider, child) {
        final activeAlerts = alertsProvider.activeAlerts;

        if (alertsProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (activeAlerts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_off,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No active alerts',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap + to create your first alert',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: activeAlerts.length,
          itemBuilder: (context, index) {
            final alert = activeAlerts[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AlertCard(
                alert: alert,
                onToggle: () => alertsProvider.toggleAlert(alert.id),
                onDelete: () => _deleteAlert(context, alert.id),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTriggeredAlerts() {
    return Consumer<AlertsProvider>(
      builder: (context, alertsProvider, child) {
        final triggeredAlerts = alertsProvider.triggeredAlerts;

        if (alertsProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (triggeredAlerts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No triggered alerts',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Alerts that have been triggered will appear here',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: triggeredAlerts.length,
          itemBuilder: (context, index) {
            final alert = triggeredAlerts[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AlertCard(
                alert: alert,
                onToggle: () => alertsProvider.toggleAlert(alert.id),
                onDelete: () => _deleteAlert(context, alert.id),
              ),
            );
          },
        );
      },
    );
  }

  void _showCreateAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateAlertDialog(
        onATHAlert: (assetId, assetSymbol) {
          context.read<AlertsProvider>().createATHAlert(assetId, assetSymbol);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ATH alert created successfully'),
              backgroundColor: Colors.green,
            ),
          );
        },
        onPriceAlert: (assetId, assetSymbol, type, targetPrice) {
          context.read<AlertsProvider>().createPriceAlert(
            assetId: assetId,
            assetSymbol: assetSymbol,
            type: type,
            targetPrice: targetPrice,
          );
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Price alert created successfully'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }

  void _deleteAlert(BuildContext context, String alertId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Alert'),
        content: const Text('Are you sure you want to delete this alert?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AlertsProvider>().deleteAlert(alertId);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
