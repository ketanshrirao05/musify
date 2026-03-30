require('dotenv').config();
const db = require('./db');

async function seed() {
  console.log('Seeding database...');
  await db.execute(`
    INSERT IGNORE INTO songs (title, artist, album, duration_sec, audio_url, is_premium) VALUES
    ('Midnight Drive',    'The Echoes',    'Neon Nights',    210, '/tracks/track1.mp3', 0),
    ('Solar Winds',       'AstroBeats',    'Cosmos',         185, '/tracks/track2.mp3', 0),
    ('Lost in Tokyo',     'City Pulse',    'Urban Dreams',   240, '/tracks/track3.mp3', 0),
    ('Diamond Dust',      'Luna Ray',      'Prism',          195, '/tracks/track4.mp3', 1),
    ('Electric Forest',   'Synth Wolves',  'Wild Current',   220, '/tracks/track5.mp3', 1)
  `);

  await db.execute(`
    INSERT IGNORE INTO playlists (user_id, name, is_public) VALUES (1, 'Top Hits', 1)
  `);

  console.log('Seed complete.');
  process.exit(0);
}

seed().catch(e => { console.error(e); process.exit(1); });
