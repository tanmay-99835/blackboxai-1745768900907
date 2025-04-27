const express = require('express');
const router = express.Router();

// Dummy channel analytics data
const dummyAnalytics = {
  subscribers: 12000,
  views: 500000,
  watchTime: 15000, // in hours
  cpm: 2.5, // estimated CPM in USD
};

router.post('/channel-analytics', (req, res) => {
  const { channelId, manualInput } = req.body;
  if (!channelId && !manualInput) {
    return res.status(400).json({ error: 'Channel ID or manual input is required' });
  }

  // For demo, return dummy analytics data
  res.json({ analytics: dummyAnalytics });
});

module.exports = router;
