const db = require('../config/db');

exports.getSongs = async (req, res) => {
  try {
    const [songs] = await db.execute(
      req.user.isPremium
        ? 'SELECT * FROM songs ORDER BY created_at DESC'
        : 'SELECT * FROM songs WHERE is_premium = 0 ORDER BY created_at DESC'
    );
    res.json(songs);
  } catch (err) { res.status(500).json({ error: err.message }); }
};

exports.getSong = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM songs WHERE id = ?', [req.params.id]);
    if (!rows.length) return res.status(404).json({ error: 'Song not found' });
    const song = rows[0];
    if (song.is_premium && !req.user.isPremium)
      return res.status(403).json({ error: 'Premium required' });
    res.json(song);
  } catch (err) { res.status(500).json({ error: err.message }); }
};

exports.getPlaylists = async (req, res) => {
  try {
    const [rows] = await db.execute(
      'SELECT * FROM playlists WHERE user_id = ? OR is_public = 1', [req.user.id]);
    res.json(rows);
  } catch (err) { res.status(500).json({ error: err.message }); }
};

exports.getPlaylist = async (req, res) => {
  try {
    const [playlists] = await db.execute('SELECT * FROM playlists WHERE id = ?', [req.params.id]);
    if (!playlists.length) return res.status(404).json({ error: 'Not found' });
    const [songs] = await db.execute(
      `SELECT s.* FROM songs s
       JOIN playlist_songs ps ON s.id = ps.song_id
       WHERE ps.playlist_id = ? ORDER BY ps.position`, [req.params.id]);
    res.json({ ...playlists[0], songs });
  } catch (err) { res.status(500).json({ error: err.message }); }
};
