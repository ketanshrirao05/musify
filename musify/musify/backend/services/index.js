// tokenService.js
const jwt = require('jsonwebtoken');

exports.sign = (payload) =>
  jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '7d' });

exports.verify = (token) =>
  jwt.verify(token, process.env.JWT_SECRET);

// storageService.js
const path = require('path');
const fs   = require('fs');

exports.getTrackPath = (filename) => {
  const p = path.join(__dirname, '../../storage/sample_tracks', filename);
  return fs.existsSync(p) ? p : null;
};

exports.listTracks = () => {
  const dir = path.join(__dirname, '../../storage/sample_tracks');
  return fs.readdirSync(dir).filter(f => f.endsWith('.mp3'));
};
