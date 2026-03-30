import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const CircleAvatar(radius: 48, backgroundColor: Color(0xFF1DB954),
          child: Icon(Icons.person, size: 48)),
        const SizedBox(height: 16),
        const Text('User Name', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const Text('user@email.com', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        const Chip(label: Text('Free Tier'), backgroundColor: Color(0xFF282828)),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade800),
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          onPressed: () async {
            await AuthService().logout();
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ]),
    );
  }
}
