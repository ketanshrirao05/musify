# 🎵 Musify

A Spotify-like music streaming app with Flutter frontend, Node.js/Express backend, and MySQL database.

## Features
- 🔐 JWT auth (register / login / logout)
- 🎧 Music streaming with ad injection for free tier
- ⭐ Premium subscriptions (monthly / annual), ad-free
- 📋 Playlists (public & private)
- 👤 User profiles

---

## Project Structure
```
musify/
├── frontend/          # Flutter app
│   └── lib/
│       ├── main.dart
│       ├── screens/   # login, home, player, premium, profile
│       ├── widgets/   # SongTile, MiniPlayer, PremiumBadge
│       ├── services/  # auth, music, premium API clients
│       └── models/    # Song, User, Playlist
├── backend/           # Node.js / Express API
│   ├── server.js
│   ├── routes/        # auth, music, premium
│   ├── controllers/
│   ├── middleware/    # auth JWT, validation, ads
│   ├── models/
│   ├── services/
│   └── config/        # db.js, seed.js
├── database/
│   └── schema.sql
├── storage/
│   └── sample_tracks/ # mp3 files
└── docs/
    ├── api_docs.md
    └── architecture.md
```

---

## Quick Start

### Backend
```bash
cd backend
cp .env.example .env      # fill in your DB credentials & JWT secret
npm install
mysql -u root -p < ../database/schema.sql
npm run seed              # optional: insert sample songs
npm run dev               # starts on :3000
```

### Frontend
```bash
cd frontend
flutter pub get
flutter run               # ensure backend is reachable at localhost:3000
```

---

## Environment Variables (backend/.env)
| Key | Description |
|-----|-------------|
| `PORT` | API port (default 3000) |
| `JWT_SECRET` | Secret for signing tokens |
| `DB_HOST/PORT/USER/PASSWORD/NAME` | MySQL connection |

---

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Mobile | Flutter / Dart |
| API | Node.js, Express 4 |
| Auth | JWT + bcrypt |
| Database | MySQL 8 |
| Storage | Local filesystem (→ S3 in prod) |
