import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass  = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    final ok = await AuthService().login(_email.text, _pass.text);
    setState(() => _loading = false);
    if (ok && mounted) Navigator.pushReplacementNamed(context, '/home');
    else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Musify', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF1DB954))),
            const SizedBox(height: 32),
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            TextField(controller: _pass, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1DB954)),
                onPressed: _loading ? null : _login,
                child: _loading ? const CircularProgressIndicator() : const Text('Log In'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
