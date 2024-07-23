import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';
import 'package:englishapp/src/services/essay_evaluation_service.dart';
import 'package:englishapp/src/presentation/pages/create_essay_page.dart';

class GradeWritingExam extends StatefulWidget {
  final String? topic;
  String? content;

  GradeWritingExam({
    String? topic,
    String? content,
  })  : topic = topic ??
      'Some people believe that in a city, the best way to travel is by car, while other people argue that bicycles are a better way of travelling in a city. Discuss both views and give your opinion.',
        content = content ??
            """
         In today's urban landscapes, the choice of transportation mode sparks considerable debate between proponents of cars and bicycles. While some advocate for the convenience and comfort of cars in navigating the city streets, others emphasize the environmental and health benefits of cycling. In this essay, I will examine both perspectives, weighing the pros and cons of each mode of transportation before presenting my own reasoned opinion.
       """;

  @override
  _GradeWritingExamState createState() => _GradeWritingExamState();
}

class _GradeWritingExamState extends State<GradeWritingExam> {
  final EssayEvaluationService essayEvaluationService =
  EssayEvaluationService(baseUrl: 'http://35.184.119.129:8550');
  Future<Map<String, dynamic>>? evaluationResult;
  List<ErrorDetail> errors = [];
  bool isLoading = false;
  final TextEditingController _essayContentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _essayContentController.text = widget.content!;
  }

  void _submitEssay() async {
    setState(() {
      isLoading = true;
    });

    try {
      final topic =
          "Some people believe that in a city, the best way to travel is by car, while other people argue that bicycles are a better way of travelling in a city. Discuss both views and give your opinion.";
      final content =
          "In today's urban landscapes, the choice of transportation mode sparks considerable debate between proponents of cars and bicycles. While some advocate for the convenience and comfort of cars in navigating the city streets, others emphasize the environmental and health benefits of cycling. In this essay, I will examine both perspectives, weighing the pros and cons of each mode of transportation before presenting my own reasoned opinion.";

      final response = await essayEvaluationService.generateErrors(
        'string',
        topic,
        content,
      );

      if (response == null || response.isEmpty) {
        throw Exception('No errors returned from the service');
      }

      setState(() {
        errors = parseErrors(response['display_errors']['bad_parts']);
        _printHighlightedErrors(errors);
      });

      final evaluation = await essayEvaluationService.evaluateEssay(
        'random id',
        topic,
        content,
      );

      setState(() {
        evaluationResult = Future.value(evaluation);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        evaluationResult = Future.error(e);
        isLoading = false;
      });
    }
  }

  List<ErrorDetail> parseErrors(List<dynamic> errorParts) {
    return errorParts.map((part) {
      return ErrorDetail(
        id: part['id'],
        highlight: part['highlight'],
        issues: (part['details'] as List<dynamic>).map((detail) {
          return Issue(
            issue: detail['issue'],
            seriousLevel: detail['serious_level'],
            idea: detail['idea'],
            type: detail['type'],
          );
        }).toList(),
      );
    }).toList();
  }

  void _printHighlightedErrors(List<ErrorDetail> errors) {
    for (var error in errors) {
      for (var issue in error.issues) {
        if (issue.type == 'sentence') {
          debugPrint('Highlighted Sentence (Yellow): ${error.highlight}');
        } else if (issue.type == 'word') {
          debugPrint('Highlighted Word (Red): ${error.highlight}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        backgroundColor: AppColors.getColor(themeIndex, 'headerBackground'),
        title: Text(
          'NAME OF ESSAY',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEssayPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildEssayTopicSection(themeIndex),
                  const SizedBox(height: 16),
                  FutureBuilder<Map<String, dynamic>>(
                    future: evaluationResult,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          isLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return Column(
                          children: [
                            _buildScoreSection(themeIndex, data),
                            const SizedBox(height: 16),
                            _buildHighlightedEssaySection(themeIndex),
                            const SizedBox(height: 16),
                            _buildErrorListSection(themeIndex, errors),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildScoreSectionPlaceholder(themeIndex),
                            const SizedBox(height: 16),
                            _buildEssayContentSection(themeIndex),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _submitEssay,
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreSectionPlaceholder(int themeIndex) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.getColor(themeIndex, 'secondaryText')
                  .withOpacity(0.25)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        '--',
                        style: TextStyle(
                          color: AppColors.getColor(themeIndex, 'headerCircle1'),
                          fontSize: 60,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'Overall Band Score',
                        style: TextStyle(
                          color: AppColors.getColor(themeIndex, 'primaryText'),
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildScoreItem('Coherence & Cohesion: --', themeIndex),
                        _buildScoreItem('Lexical Resources: --', themeIndex),
                        _buildScoreItem('Grammatical range: --', themeIndex),
                        _buildScoreItem('Task Achievement: --', themeIndex),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreSection(int themeIndex, Map<String, dynamic> data) {
    final criteria = data['criteria'];
    final bandScore = data['band_score'];

    final taskAchievementScore = criteria[0]['score'];
    final coherenceScore = criteria[1]['score'];
    final lexicalResourcesScore = criteria[2]['score'];
    final grammaticalRangeScore = criteria[3]['score'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.getColor(themeIndex, 'secondaryText')
                  .withOpacity(0.25)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        bandScore.toString(),
                        style: TextStyle(
                          color: AppColors.getColor(themeIndex, 'headerCircle1'),
                          fontSize: 60,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'Overall Band Score',
                        style: TextStyle(
                          color: AppColors.getColor(themeIndex, 'primaryText'),
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildScoreItem('Coherence & Cohesion: $coherenceScore', themeIndex),
                        _buildScoreItem('Lexical Resources: $lexicalResourcesScore', themeIndex),
                        _buildScoreItem('Grammatical range: $grammaticalRangeScore', themeIndex),
                        _buildScoreItem('Task Achievement: $taskAchievementScore', themeIndex),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem(String text, int themeIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 6, color: AppColors.getColor(themeIndex, 'primaryText')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEssayTopicSection(int themeIndex) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.getColor(themeIndex, 'secondaryText')
                  .withOpacity(0.25)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Đề bài',
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.topic ??
                  'Some people believe that in a city, the best way to travel is by car, while other people argue that bicycles are a better way of travelling in a city. Discuss both views and give your opinion.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 11,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEssayContentSection(int themeIndex) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.getColor(themeIndex, 'secondaryText')
                  .withOpacity(0.25)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bài làm',
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _essayContentController,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập nội dung bài làm tại đây...',
                hintStyle: TextStyle(
                  color: AppColors.getColor(themeIndex, 'secondaryText'),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedEssaySection(int themeIndex) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.getColor(themeIndex, 'secondaryText')
                  .withOpacity(0.25)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bài làm được đánh dấu',
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            _buildRichTextWithErrors(
                _essayContentController.text, errors, themeIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildRichTextWithErrors(
      String text, List<ErrorDetail> errors, int themeIndex) {
    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (final error in errors) {
      final startIndex = text.indexOf(error.highlight, lastMatchEnd);
      if (startIndex == -1) continue;

      final endIndex = startIndex + error.highlight.length;

      if (startIndex > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, startIndex)));
      }

      List<TextSpan> innerSpans = [];
      int innerLastMatchEnd = 0;

      for (final issue in error.issues) {
        final innerStartIndex = error.highlight.indexOf(issue.issue, innerLastMatchEnd);
        if (innerStartIndex == -1) continue;

        final innerEndIndex = innerStartIndex + issue.issue.length;

        if (innerStartIndex > innerLastMatchEnd) {
          innerSpans.add(TextSpan(
              text: error.highlight.substring(innerLastMatchEnd, innerStartIndex)));
        }

        innerSpans.add(TextSpan(
          text: issue.issue,
          style: TextStyle(
            color: Colors.red,
            decoration: TextDecoration.underline,
            decorationColor: Colors.red,
          ),
        ));

        innerLastMatchEnd = innerEndIndex;
      }

      if (innerLastMatchEnd < error.highlight.length) {
        innerSpans.add(TextSpan(text: error.highlight.substring(innerLastMatchEnd)));
      }

      spans.add(TextSpan(
        children: innerSpans,
        style: TextStyle(
          backgroundColor: error.issues.any((issue) => issue.type == 'sentence')
              ? Colors.yellow.withOpacity(0.3)
              : Colors.transparent,
          color: error.issues.any((issue) => issue.type == 'word')
              ? Colors.red
              : Colors.black,
          decoration: error.issues.any((issue) => issue.type == 'sentence')
              ? TextDecoration.underline
              : TextDecoration.none,
          decorationColor: error.issues.any((issue) => issue.type == 'sentence')
              ? Colors.yellow
              : Colors.transparent,
        ),
      ));

      lastMatchEnd = endIndex;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: AppColors.getColor(themeIndex, 'primaryText'),
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        children: spans,
      ),
    );
  }

  Widget _buildErrorListSection(int themeIndex, List<ErrorDetail> errors) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.getColor(themeIndex, 'secondaryText')
                  .withOpacity(0.25)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Danh sách lỗi từ',
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: errors.length,
              itemBuilder: (context, index) {
                final error = errors[index];
                return ExpansionTile(
                  title: Text(
                    'Lỗi từ #${error.id}',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  children: error.issues.map((issue) {
                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              issue.issue,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildSeriousLevelIndicator(issue.seriousLevel),
                        ],
                      ),
                      subtitle: Text(
                        'Idea: ${issue.idea}',
                        style: TextStyle(
                          color: AppColors.getColor(themeIndex, 'primaryText'),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeriousLevelIndicator(int seriousLevel) {
    Color getColor(int level) {
      switch (level) {
        case 1:
          return Colors.blue;
        case 2:
          return Colors.green;
        case 3:
          return Colors.yellow;
        case 4:
          return Colors.orange;
        case 5:
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Row(
      children: List.generate(seriousLevel, (index) {
        return Container(
          width: 10,
          height: 10,
          color: getColor(seriousLevel),
          margin: EdgeInsets.symmetric(horizontal: 1),
        );
      }),
    );
  }
}

class ErrorDetail {
  final int id;
  final String highlight;
  final List<Issue> issues;

  ErrorDetail({
    required this.id,
    required this.highlight,
    required this.issues,
  });
}

class Issue {
  final String issue;
  final int seriousLevel;
  final String idea;
  final String type;

  Issue({
    required this.issue,
    required this.seriousLevel,
    required this.idea,
    required this.type,
  });
}
