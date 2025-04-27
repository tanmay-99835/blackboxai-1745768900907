const express = require('express');
const router = express.Router();

router.post('/seo-analyzer', (req, res) => {
  const { title, description, tags } = req.body;
  if (!title || !description || !tags) {
    return res.status(400).json({ error: 'Title, description, and tags are required' });
  }

  // Dummy SEO analysis logic
  let score = 50;
  const suggestions = [];

  if (title.length < 30) {
    score -= 10;
    suggestions.push('Title is too short. Aim for 30-60 characters.');
  } else if (title.length > 60) {
    score -= 5;
    suggestions.push('Title is too long. Aim for 30-60 characters.');
  } else {
    score += 10;
  }

  if (description.length < 100) {
    score -= 10;
    suggestions.push('Description is too short. Aim for at least 100 characters.');
  } else {
    score += 10;
  }

  if (!tags || tags.length === 0) {
    score -= 15;
    suggestions.push('Add relevant tags to improve discoverability.');
  } else if (tags.length > 15) {
    score -= 5;
    suggestions.push('Too many tags. Use 5-15 relevant tags.');
  } else {
    score += 10;
  }

  if (score > 100) score = 100;
  if (score < 0) score = 0;

  res.json({ score, suggestions });
});

module.exports = router;
