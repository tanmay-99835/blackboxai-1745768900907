const express = require('express');
const router = express.Router();

// Dummy hashtag suggestions
const dummyHashtags = [
  '#YouTubeGrowth',
  '#ViralVideo',
  '#ContentCreator',
  '#YouTubeTips',
  '#VideoMarketing',
  '#YouTubeSEO',
  '#CreatorCommunity',
  '#YouTubeShorts',
  '#VideoIdeas',
  '#GrowYourChannel',
];

router.post('/hashtag-suggestion', (req, res) => {
  const { topic } = req.body;
  if (!topic) {
    return res.status(400).json({ error: 'Topic is required' });
  }

  // For demo, return all dummy hashtags
  res.json({ hashtags: dummyHashtags });
});

module.exports = router;
