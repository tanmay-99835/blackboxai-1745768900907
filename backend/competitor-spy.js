const express = require('express');
const router = express.Router();

// Dummy competitor data
const dummyCompetitorData = {
  recentUploads: [
    {
      title: 'How to Grow Your YouTube Channel Fast',
      tags: ['YouTubeGrowth', 'ChannelTips', 'ViralVideos'],
      views: 15000,
      likes: 1200,
      comments: 300,
      uploadDate: '2024-04-01',
    },
    {
      title: 'Top 10 Video Ideas for Beginners',
      tags: ['VideoIdeas', 'YouTubeTips', 'ContentCreation'],
      views: 12000,
      likes: 900,
      comments: 150,
      uploadDate: '2024-03-25',
    },
  ],
};

router.post('/competitor-spy', (req, res) => {
  const { competitorLink } = req.body;
  if (!competitorLink) {
    return res.status(400).json({ error: 'Competitor channel link is required' });
  }

  // For demo, return dummy competitor data
  res.json({ competitorData: dummyCompetitorData });
});

module.exports = router;
