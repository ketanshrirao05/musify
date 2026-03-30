import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class PremiumService {
  static const _base = 'http://localhost:3000/api';

  Future<bool> subscribe(String plan) async {
    final token = await AuthService().getToken();
    final res = await http.post(Uri.parse('$_base/premium/subscribe'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode({'plan': plan}));
    return res.statusCode == 200;
  }

  Future<bool> checkStatus() async {
    final token = await AuthService().getToken();
    final res = await http.get(Uri.parse('$_base/premium/status'),
      headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) return jsonDecode(res.body)['isPremium'] ?? false;
    return false;
  }
}
