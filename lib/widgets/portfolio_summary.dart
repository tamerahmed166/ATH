import 'package:flutter/material.dart';

class PortfolioSummary extends StatelessWidget {
  final double totalValue;
  final double totalDayChange;
  final double totalDayChangePercent;

  const PortfolioSummary({
    super.key,
    required this.totalValue,
    required this.totalDayChange,
    required this.totalDayChangePercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue[600]!,
            Colors.blue[800]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Portfolio Value',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${totalValue.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                totalDayChange >= 0 ? Icons.trending_up : Icons.trending_down,
                color: totalDayChange >= 0 ? Colors.green[300] : Colors.red[300],
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                '${totalDayChange >= 0 ? '+' : ''}\$${totalDayChange.toStringAsFixed(2)}',
                style: TextStyle(
                  color: totalDayChange >= 0 ? Colors.green[300] : Colors.red[300],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${totalDayChangePercent >= 0 ? '+' : ''}${totalDayChangePercent.toStringAsFixed(2)}%)',
                style: TextStyle(
                  color: totalDayChange >= 0 ? Colors.green[300] : Colors.red[300],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
