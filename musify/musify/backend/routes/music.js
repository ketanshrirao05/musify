const router = require('express').Router();
const { getSongs, getSong, getPlaylists, getPlaylist } = require('../controllers/musicController');
const auth = require('../middleware/auth');
const { adMiddleware } = require('../middleware/ads');

router.get('/songs',           auth, adMiddleware, getSongs);
router.get('/songs/:id',       auth, adMiddleware, getSong);
router.get('/playlists',       auth, getPlaylists);
router.get('/playlists/:id',   auth, getPlaylist);

module.exports = router;
