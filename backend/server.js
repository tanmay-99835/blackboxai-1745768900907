require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { Configuration, OpenAIApi } = require('openai');

const app = express();
const port = 3000;

const keywordResearchRouter = require('./keyword-research');
const scriptGeneratorRouter = require('./script-generator');
const seoAnalyzerRouter = require('./seo-analyzer');
const hashtagSuggestionRouter = require('./hashtag-suggestion');
const uploadChecklistRouter = require('./upload-checklist');
const channelAnalyticsRouter = require('./channel-analytics');
const competitorSpyRouter = require('./competitor-spy');
const contentCalendarRouter = require('./content-calendar');
const communityPostIdeasRouter = require('./community-post-ideas');
const shortsIdeaGeneratorRouter = require('./shorts-idea-generator');

app.use(cors());
app.use(express.json());

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);

app.use('/api', keywordResearchRouter);
app.use('/api', scriptGeneratorRouter);
app.use('/api', seoAnalyzerRouter);
app.use('/api', hashtagSuggestionRouter);
app.use('/api', uploadChecklistRouter);
app.use('/api', channelAnalyticsRouter);
app.use('/api', competitorSpyRouter);
app.use('/api', contentCalendarRouter);
app.use('/api', communityPostIdeasRouter);
app.use('/api', shortsIdeaGeneratorRouter);

app.post('/api/title-generator', async (req, res) => {
  const { topic } = req.body;
  if (!topic) {
    return res.status(400).json({ error: 'Topic is required' });
  }

  try {
    const prompt = `Generate 5 SEO-optimized, clickbait-friendly YouTube video titles for the topic: "${topic}". Return the titles as a JSON array.`;

    const completion = await openai.createCompletion({
      model: 'text-davinci-003',
      prompt: prompt,
      max_tokens: 150,
      temperature: 0.7,
      n: 1,
      stop: null,
    });

    const text = completion.data.choices[0].text.trim();

    // Parse titles from the response text
    let titles = [];
    try {
      titles = JSON.parse(text);
    } catch (e) {
      // Fallback: split by new lines if JSON parse fails
      titles = text.split('\n').map(t => t.trim()).filter(t => t.length > 0);
    }

    res.json({ titles });
  } catch (error) {
    console.error('OpenAI API error:', error);
    res.status(500).json({ error: 'Failed to generate titles' });
  }
});

app.listen(port, () => {
  console.log("Backend server running at http://localhost:" + port);
});
