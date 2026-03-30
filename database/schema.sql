-- Musify Database Schema
-- Run: mysql -u root -p < schema.sql

CREATE DATABASE IF NOT EXISTS musify CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE musify;

-- ─── USERS ────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
  id            INT UNSIGNED    AUTO_INCREMENT PRIMARY KEY,
  name          VARCHAR(100)    NOT NULL,
  email         VARCHAR(255)    NOT NULL UNIQUE,
  password_hash VARCHAR(255)    NOT NULL,
  is_premium    TINYINT(1)      NOT NULL DEFAULT 0,
  avatar_url    VARCHAR(512)    DEFAULT NULL,
  created_at    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_email (email)
);

-- ─── SONGS ────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS songs (
  id            INT UNSIGNED    AUTO_INCREMENT PRIMARY KEY,
  title         VARCHAR(255)    NOT NULL,
  artist        VARCHAR(255)    NOT NULL,
  album         VARCHAR(255)    DEFAULT NULL,
  genre         VARCHAR(100)    DEFAULT NULL,
  duration_sec  INT UNSIGNED    NOT NULL DEFAULT 0,
  audio_url     VARCHAR(512)    NOT NULL,
  album_art     VARCHAR(512)    DEFAULT NULL,
  is_premium    TINYINT(1)      NOT NULL DEFAULT 0,
  play_count    INT UNSIGNED    NOT NULL DEFAULT 0,
  created_at    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_artist (artist),
  INDEX idx_genre  (genre)
);

-- ─── PLAYLISTS ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS playlists (
  id            INT UNSIGNED    AUTO_INCREMENT PRIMARY KEY,
  user_id       INT UNSIGNED    NOT NULL,
  name          VARCHAR(255)    NOT NULL,
  description   TEXT            DEFAULT NULL,
  cover_url     VARCHAR(512)    DEFAULT NULL,
  is_public     TINYINT(1)      NOT NULL DEFAULT 0,
  created_at    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user (user_id)
);

-- ─── PLAYLIST_SONGS (junction) ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS playlist_songs (
  playlist_id   INT UNSIGNED    NOT NULL,
  song_id       INT UNSIGNED    NOT NULL,
  position      SMALLINT        NOT NULL DEFAULT 0,
  added_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (playlist_id, song_id),
  FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,
  FOREIGN KEY (song_id)     REFERENCES songs(id)     ON DELETE CASCADE
);

-- ─── SUBSCRIPTIONS ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS subscriptions (
  id            INT UNSIGNED    AUTO_INCREMENT PRIMARY KEY,
  user_id       INT UNSIGNED    NOT NULL UNIQUE,
  plan          ENUM('monthly','annual') NOT NULL DEFAULT 'monthly',
  price         DECIMAL(8,2)    NOT NULL,
  status        ENUM('active','cancelled','expired') NOT NULL DEFAULT 'active',
  started_at    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
  ends_at       TIMESTAMP       NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_status (status)
);

-- ─── PLAY HISTORY ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS play_history (
  id            INT UNSIGNED    AUTO_INCREMENT PRIMARY KEY,
  user_id       INT UNSIGNED    NOT NULL,
  song_id       INT UNSIGNED    NOT NULL,
  played_at     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
  INDEX idx_user_played (user_id, played_at)
);
