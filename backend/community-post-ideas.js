const express = require('express');
const router = express.Router();
const { Configuration, OpenAIApi } = require('openai');

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);

router.post('/community-post-ideas', async (req, res) => {
  const { topic } = req.body;
  if (!topic) {
    return res.status(400).json({ error: 'Topic is required' });
  }

  try {
    const prompt = `Generate 5 engaging community post ideas for a YouTube channel about the topic: "${topic}". Return the ideas as a JSON array.`;

    const completion = await openai.createCompletion({
      model: 'text-davinci-003',
      prompt: prompt,
      max_tokens: 150,
      temperature: 0.7,
      n: 1,
      stop: null,
    });

    const text = completion.data.choices[0].text.trim();

    let ideas = [];
    try {
      ideas = JSON.parse(text);
    } catch (e) {
      ideas = text.split('\n').map(i => i.trim()).filter(i => i.length > 0);
    }

    res.json({ ideas });
  } catch (error) {
    console.error('OpenAI API error:', error);
    res.status(500).json({ error: 'Failed to generate community post ideas' });
  }
});

module.exports = router;
