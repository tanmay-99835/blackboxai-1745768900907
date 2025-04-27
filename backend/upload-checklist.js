const express = require('express');
const router = express.Router();

let checklist = [
  { id: 1, task: 'Write video title', completed: false },
  { id: 2, task: 'Create thumbnail', completed: false },
  { id: 3, task: 'Write description', completed: false },
  { id: 4, task: 'Add tags', completed: false },
  { id: 5, task: 'Schedule publish date', completed: false },
];

// Get checklist
router.get('/upload-checklist', (req, res) => {
  res.json({ checklist });
});

// Update checklist item
router.put('/upload-checklist/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const { completed } = req.body;
  const item = checklist.find(i => i.id === id);
  if (!item) {
    return res.status(404).json({ error: 'Task not found' });
  }
  item.completed = completed;
  res.json({ item });
});

module.exports = router;
