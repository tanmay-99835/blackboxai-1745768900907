const express = require('express');
const router = express.Router();

// Dummy keyword research data
const dummyKeywords = [
  { keyword: 'youtube growth tips', difficulty: 30, searchVolume: 5000 },
  { keyword: 'how to get subscribers fast', difficulty: 25, searchVolume: 4500 },
  { keyword: 'best video editing software', difficulty: 40, searchVolume: 6000 },
  { keyword: 'youtube seo optimization', difficulty: 35, searchVolume: 4000 },
  { keyword: 'viral video ideas', difficulty: 20, searchVolume: 3500 },
];

router.post('/keyword-research', (req, res) => {
  const { topic } = req.body;
  if (!topic) {
    return res.status(400).json({ error: 'Topic is required' });
  }

  // For demo, return all dummy keywords containing the topic substring (case-insensitive)
  const results = dummyKeywords.filter(k =>
    k.keyword.toLowerCase().includes(topic.toLowerCase())
  );

  res.json({ keywords: results });
});

module.exports = router;
