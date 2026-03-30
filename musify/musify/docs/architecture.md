# Musify — Architecture

```
┌──────────────────────────────────────────────────────────┐
│                     Flutter App                          │
│                                                          │
│  LoginScreen  HomeScreen  PlayerScreen  PremiumScreen    │
│       │            │            │             │          │
│       └────────────┴────────────┴─────────────┘          │
│                         │                                │
│              Services (HTTP + SharedPrefs)               │
│         AuthService  MusicService  PremiumService        │
└────────────────────────┬─────────────────────────────────┘
                         │ HTTPS / REST
                         ▼
┌──────────────────────────────────────────────────────────┐
│               Node.js / Express API  :3000               │
│                                                          │
│  /api/auth     /api/music      /api/premium              │
│      │               │               │                   │
│  AuthCtrl      MusicCtrl      PremiumCtrl                │
│      │               │               │                   │
│  Middleware:  JWT auth │ Validation │ Ad injection        │
│                        │                                 │
│          Config: db.js  │  Services: token, storage      │
└────────────────────────┬────────────────────────────────-┘
                         │ mysql2
                         ▼
┌──────────────────────────────────────────────────────────┐
│                     MySQL 8                              │
│                                                          │
│  users  ──┬── playlists ──── playlist_songs             │
│            │                       │                     │
│            └── subscriptions    songs                    │
│            └── play_history                              │
└──────────────────────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────────┐
│         Local Storage  /storage/sample_tracks/           │
│         (→ AWS S3 / GCS in production)                   │
│                                                          │
│   track1.mp3 … track5.mp3    ads/ad_sample.mp3           │
└──────────────────────────────────────────────────────────┘

Ad Flow (Free Tier):
  Request → auth middleware → adMiddleware (count % 3 == 0 → attach ad)
                                         → controller returns songs + ad meta

Premium Flow:
  POST /premium/subscribe → update subscriptions table → set users.is_premium=1
  JWT refreshed on next login with isPremium=true → ad middleware skipped
```
