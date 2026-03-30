import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';

void main() => runApp(const MusifyApp());

class MusifyApp extends StatelessWidget {
  const MusifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1DB954),
          background: Color(0xFF121212),
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: FutureBuilder<bool>(
        future: AuthService().isLoggedIn(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          return snap.data == true ? const HomeScreen() : const LoginScreen();
        },
      ),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
