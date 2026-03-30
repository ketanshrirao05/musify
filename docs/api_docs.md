# Musify API Documentation

Base URL: `http://localhost:3000/api`

All protected routes require: `Authorization: Bearer <token>`

---

## Auth

### POST /auth/register
**Body:** `{ name, email, password }`
**Response:** `201 { id, message }`

### POST /auth/login
**Body:** `{ email, password }`
**Response:** `200 { token, user: { id, name, email, isPremium } }`

### POST /auth/logout
**Response:** `200 { message }`

---

## Music 🔒

### GET /music/songs
Returns all accessible songs (premium songs hidden for free users).
**Response:** `200 [ { id, title, artist, album, duration_sec, audio_url, is_premium } ]`
Free users: ad object may be appended in `X-Ad` response header.

### GET /music/songs/:id
**Response:** `200 { song }` | `403 { error: "Premium required" }`

### GET /music/playlists
**Response:** `200 [ { id, name, is_public } ]`

### GET /music/playlists/:id
**Response:** `200 { id, name, songs: [...] }`

---

## Premium 🔒

### GET /premium/status
**Response:** `200 { isPremium: bool, subscription: { plan, ends_at, status } | null }`

### POST /premium/subscribe
**Body:** `{ plan: "monthly" | "annual" }`
**Response:** `200 { message, plan, endsAt }`

### POST /premium/cancel
**Response:** `200 { message }`

---

## Static Audio
`GET /tracks/:filename.mp3` — streams audio file directly.

---

## Error Responses
| Code | Meaning |
|------|---------|
| 400 | Validation error |
| 401 | Unauthenticated |
| 403 | Premium required |
| 404 | Not found |
| 409 | Conflict (duplicate email) |
| 500 | Server error |
