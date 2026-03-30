// player_screen.dart
import 'package:flutter/material.dart';
import '../models/song.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;
  const PlayerScreen({super.key, required this.song});
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _playing = false;
  double _pos = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(children: [
          Container(height: 240, color: const Color(0xFF1DB954).withOpacity(0.2),
            child: const Center(child: Icon(Icons.album, size: 120, color: Color(0xFF1DB954)))),
          const SizedBox(height: 32),
          Text(widget.song.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(widget.song.artist, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Slider(value: _pos, onChanged: (v) => setState(() => _pos = v), activeColor: const Color(0xFF1DB954)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(icon: const Icon(Icons.skip_previous), iconSize: 40, onPressed: () {}),
            IconButton(
              icon: Icon(_playing ? Icons.pause_circle : Icons.play_circle),
              iconSize: 72,
              color: const Color(0xFF1DB954),
              onPressed: () => setState(() => _playing = !_playing),
            ),
            IconButton(icon: const Icon(Icons.skip_next), iconSize: 40, onPressed: () {}),
          ]),
        ]),
      ),
    );
  }
}
