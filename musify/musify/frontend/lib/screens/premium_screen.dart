import 'package:flutter/material.dart';
import '../services/premium_service.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(children: [
        const Text('Go Premium', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Ad-free music, offline listening & more', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 32),
        _PlanCard(title: 'Monthly', price: '\$9.99/mo', onTap: () => PremiumService().subscribe('monthly')),
        const SizedBox(height: 16),
        _PlanCard(title: 'Annual', price: '\$99.99/yr', onTap: () => PremiumService().subscribe('annual')),
      ]),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title, price;
  final VoidCallback onTap;
  const _PlanCard({required this.title, required this.price, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
    color: const Color(0xFF1E1E1E),
    child: ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(price, style: const TextStyle(color: Color(0xFF1DB954))),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1DB954)),
        onPressed: onTap,
        child: const Text('Subscribe'),
      ),
    ),
  );
}
