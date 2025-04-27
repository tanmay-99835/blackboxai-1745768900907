import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(CreatorBoostApp());
}

class CreatorBoostApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CreatorBoost',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        '/title-generator': (context) => TitleGeneratorPage(),
        '/keyword-research': (context) => KeywordResearchPage(),
        '/thumbnail-maker': (context) => ThumbnailMakerPage(),
        '/script-generator': (context) => ScriptGeneratorPage(),
        '/seo-analyzer': (context) => SEOAnalyzerPage(),
        '/hashtag-suggestion': (context) => HashtagSuggestionPage(),
        '/upload-checklist': (context) => UploadChecklistPage(),
        '/channel-analytics': (context) => ChannelAnalyticsPage(),
        '/competitor-spy': (context) => CompetitorSpyPage(),
        '/content-calendar': (context) => ContentCalendarPage(),
        '/community-post-ideas': (context) => CommunityPostIdeasPage(),
        '/shorts-idea-generator': (context) => ShortsIdeaGeneratorPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CreatorBoost - YouTube Growth App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('AI Video Title Generator'),
                onPressed: () {
                  Navigator.pushNamed(context, '/title-generator');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Keyword Research Tool'),
                onPressed: () {
                  Navigator.pushNamed(context, '/keyword-research');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Thumbnail Maker'),
                onPressed: () {
                  Navigator.pushNamed(context, '/thumbnail-maker');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Script Generator'),
                onPressed: () {
                  Navigator.pushNamed(context, '/script-generator');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('SEO Analyzer'),
                onPressed: () {
                  Navigator.pushNamed(context, '/seo-analyzer');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Hashtag Suggestion Tool'),
                onPressed: () {
                  Navigator.pushNamed(context, '/hashtag-suggestion');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Upload Checklist'),
                onPressed: () {
                  Navigator.pushNamed(context, '/upload-checklist');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Channel Analytics Tracker'),
                onPressed: () {
                  Navigator.pushNamed(context, '/channel-analytics');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Competitor Spy Tool'),
                onPressed: () {
                  Navigator.pushNamed(context, '/competitor-spy');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Content Calendar'),
                onPressed: () {
                  Navigator.pushNamed(context, '/content-calendar');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShortsIdeaGeneratorPage extends StatefulWidget {
  @override
  _ShortsIdeaGeneratorPageState createState() => _ShortsIdeaGeneratorPageState();
}

class _ShortsIdeaGeneratorPageState extends State<ShortsIdeaGeneratorPage> {
  final TextEditingController _topicController = TextEditingController();
  List<String> _ideas = [];
  bool _loading = false;
  String? _error;

  Future<void> _generateIdeas() async {
    final topic = _topicController.text.trim();
    if (topic.isEmpty) {
      setState(() {
        _error = 'Please enter a topic';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
      _ideas = [];
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/shorts-idea-generator'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'topic': topic}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _ideas = List<String>.from(data['ideas']);
        });
      } else {
        setState(() {
          _error = 'Failed to generate shorts ideas';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shorts Idea Generator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _topicController,
              decoration: InputDecoration(
                labelText: 'Enter topic',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _generateIdeas,
              child: _loading ? CircularProgressIndicator() : Text('Generate Shorts Ideas'),
            ),
            SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            Expanded(
              child: ListView.builder(
                itemCount: _ideas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.video_library),
                    title: Text(_ideas[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompetitorSpyPage extends StatefulWidget {
  @override
  _CompetitorSpyPageState createState() => _CompetitorSpyPageState();
}

class _CompetitorSpyPageState extends State<CompetitorSpyPage> {
  final TextEditingController _competitorLinkController = TextEditingController();
  Map<String, dynamic>? _competitorData;
  bool _loading = false;
  String? _error;

  Future<void> _fetchCompetitorData() async {
    final competitorLink = _competitorLinkController.text.trim();
    if (competitorLink.isEmpty) {
      setState(() {
        _error = 'Please enter competitor channel link';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
      _competitorData = null;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/competitor-spy'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'competitorLink': competitorLink}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _competitorData = data['competitorData'];
        });
      } else {
        setState(() {
          _error = 'Failed to fetch competitor data';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _competitorLinkController.dispose();
    super.dispose();
  }

  Widget _buildUploadItem(Map<String, dynamic> upload) {
    return ListTile(
      title: Text(upload['title']),
      subtitle: Text('Tags: ${upload['tags'].join(', ')}\nViews: ${upload['views']}, Likes: ${upload['likes']}, Comments: ${upload['comments']}\nUploaded on: ${upload['uploadDate']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Competitor Spy Tool'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _competitorLinkController,
              decoration: InputDecoration(
                labelText: 'Competitor Channel Link',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _fetchCompetitorData,
              child: _loading ? CircularProgressIndicator() : Text('Get Competitor Data'),
            ),
            SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            if (_competitorData != null) ...[
              Text('Recent Uploads:', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: _competitorData!['recentUploads'].length,
                  itemBuilder: (context, index) {
                    return _buildUploadItem(_competitorData!['recentUploads'][index]);
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ChannelAnalyticsPage extends StatefulWidget {
  @override
  _ChannelAnalyticsPageState createState() => _ChannelAnalyticsPageState();
}

class _ChannelAnalyticsPageState extends State<ChannelAnalyticsPage> {
  final TextEditingController _channelIdController = TextEditingController();
  bool _manualInput = false;
  final TextEditingController _subscribersController = TextEditingController();
  final TextEditingController _viewsController = TextEditingController();
  final TextEditingController _watchTimeController = TextEditingController();
  final TextEditingController _cpmController = TextEditingController();

  Map<String, dynamic>? _analytics;
  bool _loading = false;
  String? _error;

  Future<void> _fetchAnalytics() async {
    final channelId = _channelIdController.text.trim();
    final manualInput = _manualInput;
    final subscribers = int.tryParse(_subscribersController.text.trim()) ?? 0;
    final views = int.tryParse(_viewsController.text.trim()) ?? 0;
    final watchTime = double.tryParse(_watchTimeController.text.trim()) ?? 0.0;
    final cpm = double.tryParse(_cpmController.text.trim()) ?? 0.0;

    if (!manualInput && channelId.isEmpty) {
      setState(() {
        _error = 'Please enter channel ID or use manual input';
      });
      return;
    }

    if (manualInput && (subscribers == 0 || views == 0)) {
      setState(() {
        _error = 'Please enter valid manual inputs';
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _analytics = null;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/channel-analytics'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'channelId': manualInput ? null : channelId,
          'manualInput': manualInput ? {
            'subscribers': subscribers,
            'views': views,
            'watchTime': watchTime,
            'cpm': cpm,
          } : null,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _analytics = data['analytics'];
        });
      } else {
        setState(() {
          _error = 'Failed to fetch analytics';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _channelIdController.dispose();
    _subscribersController.dispose();
    _viewsController.dispose();
    _watchTimeController.dispose();
    _cpmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Channel Analytics Tracker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SwitchListTile(
                title: Text('Manual Input'),
                value: _manualInput,
                onChanged: (value) {
                  setState(() {
                    _manualInput = value;
                  });
                },
              ),
              if (!_manualInput)
                TextField(
                  controller: _channelIdController,
                  decoration: InputDecoration(
                    labelText: 'Channel ID',
                    border: OutlineInputBorder(),
                  ),
                ),
              if (_manualInput) ...[
                TextField(
                  controller: _subscribersController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Subscribers',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _viewsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Views',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _watchTimeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Watch Time (hours)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _cpmController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'CPM Estimator (USD)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loading ? null : _fetchAnalytics,
                child: _loading ? CircularProgressIndicator() : Text('Get Analytics'),
              ),
              SizedBox(height: 20),
              if (_error != null)
                Text(_error!, style: TextStyle(color: Colors.red)),
              if (_analytics != null) ...[
                Text('Subscribers: ${_analytics!['subscribers']}'),
                Text('Views: ${_analytics!['views']}'),
                Text('Watch Time: ${_analytics!['watchTime']} hours'),
                Text('CPM Estimator: \$${_analytics!['cpm']}'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class UploadChecklistPage extends StatefulWidget {
  @override
  _UploadChecklistPageState createState() => _UploadChecklistPageState();
}

class _UploadChecklistPageState extends State<UploadChecklistPage> {
  List<dynamic> _checklist = [];
  bool _loading = false;
  String? _error;

  Future<void> _fetchChecklist() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/upload-checklist'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _checklist = data['checklist'];
        });
      } else {
        setState(() {
          _error = 'Failed to load checklist';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _toggleTask(int id, bool completed) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3000/api/upload-checklist/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'completed': completed}),
      );
      if (response.statusCode == 200) {
        _fetchChecklist();
      } else {
        setState(() {
          _error = 'Failed to update task';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchChecklist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Checklist'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  itemCount: _checklist.length,
                  itemBuilder: (context, index) {
                    final item = _checklist[index];
                    return CheckboxListTile(
                      title: Text(item['task']),
                      value: item['completed'],
                      onChanged: (value) {
                        if (value != null) {
                          _toggleTask(item['id'], value);
                        }
                      },
                    );
                  },
                ),
    );
  }
}

class HashtagSuggestionPage extends StatefulWidget {
  @override
  _HashtagSuggestionPageState createState() => _HashtagSuggestionPageState();
}

class _HashtagSuggestionPageState extends State<HashtagSuggestionPage> {
  final TextEditingController _topicController = TextEditingController();
  List<String> _hashtags = [];
  bool _loading = false;
  String? _error;

  Future<void> _getHashtags() async {
    final topic = _topicController.text.trim();
    if (topic.isEmpty) {
      setState(() {
        _error = 'Please enter a topic';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
      _hashtags = [];
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/hashtag-suggestion'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'topic': topic}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _hashtags = List<String>.from(data['hashtags']);
        });
      } else {
        setState(() {
          _error = 'Failed to fetch hashtags';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hashtag Suggestion Tool'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _topicController,
              decoration: InputDecoration(
                labelText: 'Enter topic or keyword',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _getHashtags,
              child: _loading ? CircularProgressIndicator() : Text('Get Hashtags'),
            ),
            SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            Expanded(
              child: ListView.builder(
                itemCount: _hashtags.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.tag),
                    title: Text(_hashtags[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SEOAnalyzerPage extends StatefulWidget {
  @override
  _SEOAnalyzerPageState createState() => _SEOAnalyzerPageState();
}

class _SEOAnalyzerPageState extends State<SEOAnalyzerPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  int? _score;
  List<String> _suggestions = [];
  bool _loading = false;
  String? _error;

  Future<void> _analyzeSEO() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final tags = _tagsController.text.trim().split(',').map((e) => e.trim()).toList();

    if (title.isEmpty || description.isEmpty || tags.isEmpty) {
      setState(() {
        _error = 'Please fill in all fields';
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _score = null;
      _suggestions = [];
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/seo-analyzer'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': title, 'description': description, 'tags': tags}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _score = data['score'];
          _suggestions = List<String>.from(data['suggestions']);
        });
      } else {
        setState(() {
          _error = 'Failed to analyze SEO';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Widget _buildSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _suggestions.map((s) => Text('- $s')).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SEO Analyzer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _tagsController,
                decoration: InputDecoration(
                  labelText: 'Tags (comma separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loading ? null : _analyzeSEO,
                child: _loading ? CircularProgressIndicator() : Text('Analyze SEO'),
              ),
              SizedBox(height: 20),
              if (_error != null)
                Text(_error!, style: TextStyle(color: Colors.red)),
              if (_score != null) ...[
                Text('SEO Score: $_score', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('Suggestions:', style: TextStyle(fontWeight: FontWeight.bold)),
                _buildSuggestions(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ScriptGeneratorPage extends StatefulWidget {
  @override
  _ScriptGeneratorPageState createState() => _ScriptGeneratorPageState();
}

class _ScriptGeneratorPageState extends State<ScriptGeneratorPage> {
  final TextEditingController _topicController = TextEditingController();
  String _selectedVideoType = 'Tutorial';
  Map<String, String> _script = {};
  bool _loading = false;
  String? _error;

  final List<String> _videoTypes = ['Tutorial', 'Review', 'Shorts', 'Vlog'];

  Future<void> _generateScript() async {
    final topic = _topicController.text.trim();
    if (topic.isEmpty) {
      setState(() {
        _error = 'Please enter a topic';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
      _script = {};
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/script-generator'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'topic': topic, 'videoType': _selectedVideoType}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _script = Map<String, String>.from(data['script']);
        });
      } else {
        setState(() {
          _error = 'Failed to generate script';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  Widget _buildScriptSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 4),
          Text(content),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Script Generator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedVideoType,
              items: _videoTypes
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedVideoType = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Video Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _topicController,
              decoration: InputDecoration(
                labelText: 'Enter video topic',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _generateScript,
              child: _loading ? CircularProgressIndicator() : Text('Generate Script'),
            ),
            SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            if (_script.isNotEmpty) ...[
              _buildScriptSection('Hook', _script['hook'] ?? ''),
              _buildScriptSection('Body', _script['body'] ?? ''),
              _buildScriptSection('Call to Action', _script['cta'] ?? ''),
            ],
          ],
        ),
      ),
    );
  }
}

import 'dart:ui' as ui;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ThumbnailMakerPage extends StatefulWidget {
  @override
  _ThumbnailMakerPageState createState() => _ThumbnailMakerPageState();
}

class _ThumbnailMakerPageState extends State<ThumbnailMakerPage> {
  File? _backgroundImage;
  final List<_TextInfo> _texts = [];
  Color _currentColor = Colors.white;
  double _fontSize = 24;
  final TextEditingController _textController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _backgroundImage = File(pickedFile.path);
      });
    }
  }

  void _addText() {
    if (_textController.text.trim().isEmpty) return;
    setState(() {
      _texts.add(_TextInfo(
        text: _textController.text.trim(),
        color: _currentColor,
        fontSize: _fontSize,
      ));
      _textController.clear();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Widget _buildTextWidgets() {
    return Stack(
      children: _texts
          .map((textInfo) => Positioned(
                left: 20,
                top: 20 + _texts.indexOf(textInfo) * 40,
                child: Text(
                  textInfo.text,
                  style: TextStyle(
                    color: textInfo.color,
                    fontSize: textInfo.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thumbnail Maker'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _backgroundImage == null
                  ? Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: Center(
                        child: Text('No background image selected'),
                      ),
                    )
                  : Stack(
                      children: [
                        Image.file(_backgroundImage!),
                        _buildTextWidgets(),
                      ],
                    ),
              SizedBox(height: 12),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter text to add',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text('Font Size:'),
                  Expanded(
                    child: Slider(
                      min: 12,
                      max: 72,
                      value: _fontSize,
                      onChanged: (value) {
                        setState(() {
                          _fontSize = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Text Color:'),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Pick Text Color'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: _currentColor,
                              onColorChanged: (color) {
                                setState(() {
                                  _currentColor = color;
                                });
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text('Close'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      color: _currentColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _addText,
                child: Text('Add Text'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextInfo {
  final String text;
  final Color color;
  final double fontSize;

  _TextInfo({required this.text, required this.color, required this.fontSize});
}

class KeywordResearchPage extends StatefulWidget {
  @override
  _KeywordResearchPageState createState() => _KeywordResearchPageState();
}

class _KeywordResearchPageState extends State<KeywordResearchPage> {
  final TextEditingController _topicController = TextEditingController();
  List<dynamic> _keywords = [];
  bool _loading = false;
  String? _error;

  Future<void> _searchKeywords() async {
    final topic = _topicController.text.trim();
    if (topic.isEmpty) {
      setState(() {
        _error = 'Please enter a topic';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
      _keywords = [];
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/keyword-research'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'topic': topic}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _keywords = data['keywords'];
        });
      } else {
        setState(() {
          _error = 'Failed to fetch keywords';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keyword Research Tool'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _topicController,
              decoration: InputDecoration(
                labelText: 'Enter niche or topic',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _searchKeywords,
              child: _loading ? CircularProgressIndicator() : Text('Search Keywords'),
            ),
            SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            Expanded(
              child: ListView.builder(
                itemCount: _keywords.length,
                itemBuilder: (context, index) {
                  final keyword = _keywords[index];
                  return ListTile(
                    leading: Icon(Icons.search),
                    title: Text(keyword['keyword']),
                    subtitle: Text('Difficulty: ${keyword['difficulty']} | Search Volume: ${keyword['searchVolume']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleGeneratorPage extends StatefulWidget {
  @override
  _TitleGeneratorPageState createState() => _TitleGeneratorPageState();
}

class _TitleGeneratorPageState extends State<TitleGeneratorPage> {
  final TextEditingController _topicController = TextEditingController();
  List<String> _titles = [];
  bool _loading = false;
  String? _error;

  Future<void> _generateTitles() async {
    final topic = _topicController.text.trim();
    if (topic.isEmpty) {
      setState(() {
        _error = 'Please enter a topic';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
      _titles = [];
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/title-generator'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'topic': topic}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _titles = List<String>.from(data['titles']);
        });
      } else {
        setState(() {
          _error = 'Failed to generate titles';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Video Title Generator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _topicController,
              decoration: InputDecoration(
                labelText: 'Enter video topic',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _generateTitles,
              child: _loading ? CircularProgressIndicator() : Text('Generate Titles'),
            ),
            SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            Expanded(
              child: ListView.builder(
                itemCount: _titles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.title),
                    title: Text(_titles[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
