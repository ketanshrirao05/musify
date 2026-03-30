import 'package:flutter/material.dart';
import '../services/music_service.dart';
import '../models/song.dart';
import 'player_screen.dart';
import 'premium_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  late Future<List<Song>> _songs;

  @override
  void initState() {
    super.initState();
    _songs = MusicService().fetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [_buildFeed(), const PremiumScreen(), const ProfileScreen()];
    return Scaffold(
      appBar: AppBar(title: const Text('Musify'), backgroundColor: const Color(0xFF1DB954)),
      body: pages[_tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        backgroundColor: const Color(0xFF181818),
        selectedItemColor: const Color(0xFF1DB954),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Premium'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildFeed() => FutureBuilder<List<Song>>(
    future: _songs,
    builder: (ctx, snap) {
      if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
      return ListView.builder(
        itemCount: snap.data!.length,
        itemBuilder: (ctx, i) {
          final s = snap.data![i];
          return ListTile(
            leading: const Icon(Icons.music_note, color: Color(0xFF1DB954)),
            title: Text(s.title),
            subtitle: Text(s.artist),
            onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => PlayerScreen(song: s))),
          );
        },
      );
    },
  );
}
