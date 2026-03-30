const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
require('dotenv').config();

const authRoutes    = require('./routes/auth');
const musicRoutes   = require('./routes/music');
const premiumRoutes = require('./routes/premium');

const app = express();
app.use(helmet());
app.use(cors());
app.use(express.json());

// Static audio files
app.use('/tracks', express.static('../storage/sample_tracks'));

// Routes
app.use('/api/auth',    authRoutes);
app.use('/api/music',   musicRoutes);
app.use('/api/premium', premiumRoutes);

app.get('/health', (_, res) => res.json({ status: 'ok' }));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Musify API running on port ${PORT}`));
module.exports = app;
