This folder contains audio track files served by the backend.

Structure:
  sample_tracks/
    track1.mp3   ← Midnight Drive  – The Echoes
    track2.mp3   ← Solar Winds     – AstroBeats
    track3.mp3   ← Lost in Tokyo   – City Pulse
    track4.mp3   ← Diamond Dust    – Luna Ray      [PREMIUM]
    track5.mp3   ← Electric Forest – Synth Wolves  [PREMIUM]
    ads/
      ad_sample.mp3 ← 15-sec ad for free-tier users

Replace placeholder files with real MP3s (ensure you hold the rights).
Served via Express at: GET /tracks/<filename>
