const router = require('express').Router();
const { subscribe, getStatus, cancelSubscription } = require('../controllers/premiumController');
const auth = require('../middleware/auth');

router.post('/subscribe',  auth, subscribe);
router.get('/status',      auth, getStatus);
router.post('/cancel',     auth, cancelSubscription);

module.exports = router;
