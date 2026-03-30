import 'package:flutter/material.dart';
import '../models/song.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;
  const SongTile({super.key, required this.song, required this.onTap});

  @override
  Widget build(BuildContext context) => ListTile(
    leading: song.albumArt.isNotEmpty
      ? Image.network(song.albumArt, width: 48, height: 48, fit: BoxFit.cover)
      : const Icon(Icons.music_note, color: Color(0xFF1DB954)),
    title: Text(song.title),
    subtitle: Text(song.artist, style: const TextStyle(color: Colors.grey)),
    trailing: song.isPremium
      ? const Icon(Icons.lock, color: Colors.amber, size: 16)
      : null,
    onTap: onTap,
  );
}

class MiniPlayer extends StatelessWidget {
  final Song song;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  const MiniPlayer({super.key, required this.song, required this.isPlaying, required this.onPlayPause});

  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFF282828),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(children: [
      const Icon(Icons.music_note, color: Color(0xFF1DB954)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Text(song.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(song.artist, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ])),
      IconButton(icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow), onPressed: onPlayPause),
    ]),
  );
}

class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA500)]),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Text('PREMIUM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
  );
}
