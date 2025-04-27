const express = require('express');
const router = express.Router();
const { Configuration, OpenAIApi } = require('openai');

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);

router.post('/script-generator', async (req, res) => {
  const { topic, videoType } = req.body;
  if (!topic || !videoType) {
    return res.status(400).json({ error: 'Topic and videoType are required' });
  }

  try {
    const prompt = `Generate a YouTube video script for a ${videoType} video on the topic "${topic}". Structure the script with a hook, body, and call to action (CTA). Return the script as a JSON object with keys: hook, body, cta.`;

    const completion = await openai.createCompletion({
      model: 'text-davinci-003',
      prompt: prompt,
      max_tokens: 500,
      temperature: 0.7,
      n: 1,
      stop: null,
    });

    const text = completion.data.choices[0].text.trim();

    // Parse JSON from response text
    let script = {};
    try {
      script = JSON.parse(text);
    } catch (e) {
      // Fallback: simple parsing if JSON parse fails
      const hookMatch = text.match(/hook:(.*)body:/is);
      const bodyMatch = text.match(/body:(.*)cta:/is);
      const ctaMatch = text.match(/cta:(.*)/is);
      script.hook = hookMatch ? hookMatch[1].trim() : '';
      script.body = bodyMatch ? bodyMatch[1].trim() : '';
      script.cta = ctaMatch ? ctaMatch[1].trim() : '';
    }

    res.json({ script });
  } catch (error) {
    console.error('OpenAI API error:', error);
    res.status(500).json({ error: 'Failed to generate script' });
  }
});

module.exports = router;
