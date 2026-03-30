class Song {
  final String id, title, artist, albumArt, audioUrl;
  final bool isPremium;

  Song({required this.id, required this.title, required this.artist,
    required this.albumArt, required this.audioUrl, this.isPremium = false});

  factory Song.fromJson(Map<String, dynamic> j) => Song(
    id: j['id'], title: j['title'], artist: j['artist'],
    albumArt: j['album_art'] ?? '', audioUrl: j['audio_url'] ?? '',
    isPremium: j['is_premium'] ?? false,
  );
}

class User {
  final String id, name, email;
  final bool isPremium;
  User({required this.id, required this.name, required this.email, this.isPremium = false});
  factory User.fromJson(Map<String, dynamic> j) =>
    User(id: j['id'], name: j['name'], email: j['email'], isPremium: j['is_premium'] ?? false);
}

class Playlist {
  final String id, name;
  final List<Song> songs;
  Playlist({required this.id, required this.name, required this.songs});
}
