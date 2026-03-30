// music_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song.dart';
import 'auth_service.dart';

class MusicService {
  static const _base = 'http://localhost:3000/api';

  Future<List<Song>> fetchSongs() async {
    final token = await AuthService().getToken();
    final res = await http.get(Uri.parse('$_base/music/songs'),
      headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List).map((j) => Song.fromJson(j)).toList();
    }
    return [];
  }

  Future<List<Song>> fetchPlaylist(String id) async {
    final token = await AuthService().getToken();
    final res = await http.get(Uri.parse('$_base/music/playlists/$id'),
      headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      return (jsonDecode(res.body)['songs'] as List).map((j) => Song.fromJson(j)).toList();
    }
    return [];
  }
}

// premium_service.dart
class PremiumService {
  static const _base = 'http://localhost:3000/api';

  Future<bool> subscribe(String plan) async {
    // TODO: integrate payment gateway (Stripe etc.)
    print('Subscribing to $plan plan');
    return true;
  }

  Future<bool> checkStatus() async {
    // Call /api/premium/status
    return false;
  }
}
