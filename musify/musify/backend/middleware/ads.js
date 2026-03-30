// ads.js — inject ad metadata for free-tier users
const AD_INTERVAL = 3; // play ad every N songs
const adPool = [
  { id: 'ad1', type: 'audio', url: '/tracks/ads/ad_sample.mp3', duration: 15 },
  { id: 'ad2', type: 'banner', imageUrl: 'https://via.placeholder.com/320x50', link: '#' },
];

const playCounts = {}; // in-memory; use Redis in production

exports.adMiddleware = (req, res, next) => {
  if (req.user.isPremium) return next(); // premium = no ads

  const uid = req.user.id;
  playCounts[uid] = (playCounts[uid] || 0) + 1;

  if (playCounts[uid] % AD_INTERVAL === 0) {
    const ad = adPool[Math.floor(Math.random() * adPool.length)];
    res.locals.ad = ad;
  }
  next();
};
