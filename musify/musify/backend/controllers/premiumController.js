const db = require('../config/db');

exports.subscribe = async (req, res) => {
  try {
    const { plan } = req.body; // 'monthly' | 'annual'
    const price = plan === 'annual' ? 99.99 : 9.99;
    const endsAt = new Date();
    endsAt.setMonth(endsAt.getMonth() + (plan === 'annual' ? 12 : 1));

    await db.execute(
      `INSERT INTO subscriptions (user_id, plan, price, ends_at, status)
       VALUES (?, ?, ?, ?, 'active')
       ON DUPLICATE KEY UPDATE plan=?, price=?, ends_at=?, status='active'`,
      [req.user.id, plan, price, endsAt, plan, price, endsAt]
    );
    await db.execute('UPDATE users SET is_premium = 1 WHERE id = ?', [req.user.id]);
    res.json({ message: 'Subscribed successfully', plan, endsAt });
  } catch (err) { res.status(500).json({ error: err.message }); }
};

exports.getStatus = async (req, res) => {
  try {
    const [rows] = await db.execute(
      'SELECT * FROM subscriptions WHERE user_id = ? AND status = "active"', [req.user.id]);
    const sub = rows[0] || null;
    res.json({ isPremium: !!sub, subscription: sub });
  } catch (err) { res.status(500).json({ error: err.message }); }
};

exports.cancelSubscription = async (req, res) => {
  try {
    await db.execute(
      'UPDATE subscriptions SET status = "cancelled" WHERE user_id = ?', [req.user.id]);
    await db.execute('UPDATE users SET is_premium = 0 WHERE id = ?', [req.user.id]);
    res.json({ message: 'Subscription cancelled' });
  } catch (err) { res.status(500).json({ error: err.message }); }
};
