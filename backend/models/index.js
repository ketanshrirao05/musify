// User.js — query helpers (thin model layer over raw SQL)
const db = require('../config/db');

const User = {
  findById:    (id)    => db.execute('SELECT id,name,email,is_premium,created_at FROM users WHERE id=?', [id]).then(([r])=>r[0]),
  findByEmail: (email) => db.execute('SELECT * FROM users WHERE email=?', [email]).then(([r])=>r[0]),
  create:      (data)  => db.execute('INSERT INTO users SET ?', [data]),
  update:      (id, d) => db.execute('UPDATE users SET ? WHERE id=?', [d, id]),
};

// Song.js
const Song = {
  findAll:     (premiumOk) => db.execute(
    premiumOk ? 'SELECT * FROM songs' : 'SELECT * FROM songs WHERE is_premium=0'
  ).then(([r])=>r),
  findById:    (id) => db.execute('SELECT * FROM songs WHERE id=?', [id]).then(([r])=>r[0]),
};

// Playlist.js
const Playlist = {
  findByUser:  (uid) => db.execute('SELECT * FROM playlists WHERE user_id=? OR is_public=1',[uid]).then(([r])=>r),
  findById:    (id)  => db.execute('SELECT * FROM playlists WHERE id=?',[id]).then(([r])=>r[0]),
};

module.exports = { User, Song, Playlist };
