const express = require('express');
const router = express.Router();

let contentCalendar = [
  { id: 1, idea: 'How to grow on YouTube', publishDate: '2024-05-01', reminderSet: true },
  { id: 2, idea: 'Best video editing tools', publishDate: '2024-05-10', reminderSet: false },
];

// Get content calendar
router.get('/content-calendar', (req, res) => {
  res.json({ contentCalendar });
});

// Add new video idea
router.post('/content-calendar', (req, res) => {
  const { idea, publishDate, reminderSet } = req.body;
  if (!idea || !publishDate) {
    return res.status(400).json({ error: 'Idea and publish date are required' });
  }
  const newItem = {
    id: contentCalendar.length + 1,
    idea,
    publishDate,
    reminderSet: reminderSet || false,
  };
  contentCalendar.push(newItem);
  res.json({ newItem });
});

// Update reminder
router.put('/content-calendar/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const { reminderSet } = req.body;
  const item = contentCalendar.find(i => i.id === id);
  if (!item) {
    return res.status(404).json({ error: 'Item not found' });
  }
  item.reminderSet = reminderSet;
  res.json({ item });
});

module.exports = router;
