// lib/src/presentation/pages/grammar_tab.dart
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class GrammarRule {
  String title;
  final List<GrammarCategory> categories;

  GrammarRule({required this.title, required this.categories});

  Map<String, dynamic> toJson() => {
    'title': title,
    'categories': categories.map((category) => category.toJson()).toList(),
  };

  factory GrammarRule.fromJson(Map<String, dynamic> json) {
    return GrammarRule(
      title: json['title'] ?? 'Untitled',
      categories: (json['categories'] as List<dynamic>?)
          ?.map((catJson) => GrammarCategory.fromJson(catJson))
          .toList() ??
          [],
    );
  }
}

class GrammarCategory {
  String category;
  final List<String> words;

  GrammarCategory({required this.category, required this.words});

  Map<String, dynamic> toJson() => {
    'category': category,
    'words': words,
  };

  factory GrammarCategory.fromJson(Map<String, dynamic> json) {
    return GrammarCategory(
      category: json['category'] ?? 'Unknown',
      words: List<String>.from(json['words'] ?? []),
    );
  }
}

class GrammarTab extends StatefulWidget {
  @override
  _GrammarTabState createState() => _GrammarTabState();
}

class _GrammarTabState extends State<GrammarTab> {
  List<GrammarRule> grammarRules = [];

  @override
  void initState() {
    super.initState();
    _loadGrammarRules();
  }

  Future<void> _loadGrammarRules() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/grammar_rules.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final List<dynamic> loadedGrammarRules = json.decode(jsonData);
      setState(() {
        grammarRules = loadedGrammarRules
            .map((ruleJson) => GrammarRule.fromJson(ruleJson))
            .toList();
      });
    } else {
      grammarRules = _initialGrammarRules();
      _saveGrammarRules();
    }
  }

  Future<void> _saveGrammarRules() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/grammar_rules.json');
    await file.writeAsString(
        json.encode(grammarRules.map((rule) => rule.toJson()).toList()));
  }

  List<GrammarRule> _initialGrammarRules() {
    return [
      // Quy tắc Family Words
      GrammarRule(
        title: 'Family Words',
        categories: [
          GrammarCategory(category: 'Noun', words: ['Father', 'Mother', 'Brother', 'Sister', 'Grandfather', 'Grandmother']),
          GrammarCategory(category: 'Verb', words: ['Love', 'Care', 'Support']),
          GrammarCategory(category: 'Adjective', words: ['Caring', 'Loving', 'Supportive']),
        ],
      ),
      // Quy tắc Tense
      GrammarRule(
        title: 'Verb Tenses',
        categories: [
          GrammarCategory(category: 'Past', words: ['Was', 'Were', 'Had', 'Went']),
          GrammarCategory(category: 'Present', words: ['Is', 'Am', 'Are', 'Have']),
          GrammarCategory(category: 'Future', words: ['Will', 'Shall', 'Will be']),
          GrammarCategory(category: 'Continuous', words: ['Is going', 'Was going', 'Will be going']),
          GrammarCategory(category: 'Perfect', words: ['Has been', 'Had been', 'Will have been']),
        ],
      ),
      // Quy tắc Loại câu
      GrammarRule(
        title: 'Sentence Structures',
        categories: [
          GrammarCategory(category: 'Simple Sentence', words: ['I love you.', 'He runs fast.']),
          GrammarCategory(category: 'Compound Sentence', words: ['I went to school, and I met my friends.', 'She is tired, but she still works.']),
          GrammarCategory(category: 'Complex Sentence', words: ['When it rains, I bring my umbrella.', 'Because he was late, he missed the bus.']),
        ],
      ),
      // Quy tắc Modal Verbs
      GrammarRule(
        title: 'Modal Verbs',
        categories: [
          GrammarCategory(category: 'Possibility', words: ['Can', 'Could', 'May', 'Might']),
          GrammarCategory(category: 'Obligation', words: ['Must', 'Have to', 'Should']),
          GrammarCategory(category: 'Permission', words: ['Can', 'May']),
        ],
      ),
      // Quy tắc Question Words
      GrammarRule(
        title: 'Question Words',
        categories: [
          GrammarCategory(category: 'WH-Questions', words: ['What', 'Where', 'When', 'Why', 'How']),
          GrammarCategory(category: 'Yes/No Questions', words: ['Do', 'Does', 'Is', 'Are']),
          GrammarCategory(category: 'Tag Questions', words: ['...isn’t it?', '...don’t you?']),
        ],
      ),
      // Quy tắc Prepositions
      GrammarRule(
        title: 'Prepositions',
        categories: [
          GrammarCategory(category: 'Time', words: ['At', 'In', 'On']),
          GrammarCategory(category: 'Place', words: ['At', 'In', 'On']),
          GrammarCategory(category: 'Direction', words: ['To', 'Toward', 'Into']),
        ],
      ),
    ];
  }

  void _addGrammarRule(String title) {
    setState(() {
      grammarRules.add(GrammarRule(title: title, categories: []));
    });
    _saveGrammarRules();
  }

  void _editGrammarRule(int ruleIndex, String newTitle) {
    setState(() {
      grammarRules[ruleIndex].title = newTitle;
    });
    _saveGrammarRules();
  }

  void _deleteGrammarRule(int ruleIndex) {
    setState(() {
      grammarRules.removeAt(ruleIndex);
    });
    _saveGrammarRules();
  }

  void _addCategoryToRule(int ruleIndex, String category) {
    setState(() {
      grammarRules[ruleIndex].categories
          .add(GrammarCategory(category: category, words: []));
    });
    _saveGrammarRules();
  }

  void _editCategory(int ruleIndex, int categoryIndex, String newCategory) {
    setState(() {
      grammarRules[ruleIndex].categories[categoryIndex].category = newCategory;
    });
    _saveGrammarRules();
  }

  void _deleteCategory(int ruleIndex, int categoryIndex) {
    setState(() {
      grammarRules[ruleIndex].categories.removeAt(categoryIndex);
    });
    _saveGrammarRules();
  }

  void _addWordToCategory(int ruleIndex, int categoryIndex, String word) {
    setState(() {
      grammarRules[ruleIndex].categories[categoryIndex].words.add(word);
    });
    _saveGrammarRules();
  }

  void _editWord(int ruleIndex, int categoryIndex, int wordIndex, String newWord) {
    setState(() {
      grammarRules[ruleIndex].categories[categoryIndex].words[wordIndex] = newWord;
    });
    _saveGrammarRules();
  }

  void _deleteWord(int ruleIndex, int categoryIndex, int wordIndex) {
    setState(() {
      grammarRules[ruleIndex].categories[categoryIndex].words.removeAt(wordIndex);
    });
    _saveGrammarRules();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...grammarRules.map((rule) {
          return Column(
            children: [
              _buildSectionContainer(
                rule: rule,
                ruleIndex: grammarRules.indexOf(rule),
              ),
              const Divider(color: Colors.black),
              ElevatedButton(
                onPressed: () => _showAddCategoryDialog(context, grammarRules.indexOf(rule)),
                child: Text('Add Category to ${rule.title}'),
              ),
            ],
          );
        }).toList(),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showAddGrammarRuleDialog(context),
          child: Text('Add Grammar Rule'),
        ),
      ],
    );
  }

  Widget _buildSectionContainer({required GrammarRule rule, required int ruleIndex}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                rule.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, size: 16),
                onPressed: () => _showEditGrammarRuleDialog(context, ruleIndex),
              ),
              IconButton(
                icon: Icon(Icons.delete, size: 16),
                onPressed: () => _deleteGrammarRule(ruleIndex),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...rule.categories.map((category) => _buildWordCategory(ruleIndex, rule.categories.indexOf(category), category)).toList(),
        ],
      ),
    );
  }

  Widget _buildWordCategory(int ruleIndex, int categoryIndex, GrammarCategory category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.play_arrow, size: 16),
              const SizedBox(width: 8),
              Text(
                category.category,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, size: 16),
                onPressed: () => _showEditCategoryDialog(context, ruleIndex, categoryIndex),
              ),
              IconButton(
                icon: Icon(Icons.delete, size: 16),
                onPressed: () => _deleteCategory(ruleIndex, categoryIndex),
              ),
              IconButton(
                icon: Icon(Icons.add, size: 16),
                onPressed: () => _showAddWordDialog(context, ruleIndex, categoryIndex),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...category.words.map((word) => _buildWordItem(ruleIndex, categoryIndex, category.words.indexOf(word), word)).toList(),
        ],
      ),
    );
  }

  Widget _buildWordItem(int ruleIndex, int categoryIndex, int wordIndex, String word) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
      child: Row(
        children: [
          Text(
            word,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, size: 16),
            onPressed: () => _showEditWordDialog(context, ruleIndex, categoryIndex, wordIndex, word),
          ),
          IconButton(
            icon: Icon(Icons.delete, size: 16),
            onPressed: () => _deleteWord(ruleIndex, categoryIndex, wordIndex),
          ),
        ],
      ),
    );
  }

  void _showAddGrammarRuleDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Grammar Rule'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Enter Grammar Rule Title'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  _addGrammarRule(titleController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditGrammarRuleDialog(BuildContext context, int ruleIndex) {
    TextEditingController titleController = TextEditingController(text: grammarRules[ruleIndex].title);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Grammar Rule'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Enter New Title'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  _editGrammarRule(ruleIndex, titleController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddCategoryDialog(BuildContext context, int ruleIndex) {
    TextEditingController categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Category'),
          content: TextField(
            controller: categoryController,
            decoration: InputDecoration(hintText: 'Enter Category Name'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                if (categoryController.text.isNotEmpty) {
                  _addCategoryToRule(ruleIndex, categoryController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditCategoryDialog(BuildContext context, int ruleIndex, int categoryIndex) {
    TextEditingController categoryController = TextEditingController(text: grammarRules[ruleIndex].categories[categoryIndex].category);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Category'),
          content: TextField(
            controller: categoryController,
            decoration: InputDecoration(hintText: 'Enter New Category Name'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (categoryController.text.isNotEmpty) {
                  _editCategory(ruleIndex, categoryIndex, categoryController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddWordDialog(BuildContext context, int ruleIndex, int categoryIndex) {
    TextEditingController wordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Word'),
          content: TextField(
            controller: wordController,
            decoration: InputDecoration(hintText: 'Enter Word'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                if (wordController.text.isNotEmpty) {
                  _addWordToCategory(ruleIndex, categoryIndex, wordController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditWordDialog(BuildContext context, int ruleIndex, int categoryIndex, int wordIndex, String currentWord) {
    TextEditingController wordController = TextEditingController(text: currentWord);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Word'),
          content: TextField(
            controller: wordController,
            decoration: InputDecoration(hintText: 'Enter New Word'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (wordController.text.isNotEmpty) {
                  _editWord(ruleIndex, categoryIndex, wordIndex, wordController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
