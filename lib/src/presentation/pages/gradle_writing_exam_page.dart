// lib/src/presentation/pages/gradle_writing_exam_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';
import 'package:englishapp/src/services/essay_evaluation_service.dart';
import 'package:englishapp/src/presentation/pages/create_essay_page.dart';

class GradeWritingExam extends StatefulWidget {
  final String? topic;
  final String? content;

  GradeWritingExam({this.topic, this.content});

  @override
  _GradeWritingExamState createState() => _GradeWritingExamState();
}

class _GradeWritingExamState extends State<GradeWritingExam> {
  final EssayEvaluationService essayEvaluationService = EssayEvaluationService(baseUrl: 'http://35.184.119.129:8550');
  late Future<Map<String, dynamic>> evaluationResult;

  @override
  void initState() {
    super.initState();
    evaluationResult = essayEvaluationService.evaluateEssay(
      'random id',
      'write an essay ....',
      'in this essay, I will talk ...',
    );
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEssayPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: evaluationResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildEssayTopicSection(themeIndex),
                  const SizedBox(height: 0),
                  _buildScoreSection(themeIndex, data),
                  const SizedBox(height: 0),
                  _buildEssayContentSection(themeIndex),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
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
          border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
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
          border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
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
              widget.topic ?? 'Chưa có đề bài',
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
    final essayContent = widget.content ?? """
      In the modern-day society, professional <span style="text-decoration:underline; color:red">sportsman</span> get a big salary <span style="text-decoration:underline; color:red">compare</span> with <span style="text-decoration:underline; color:red">others</span> people who are related to <span style="text-decoration:underline; color:red">another significant jobs</span>. Some individuals think that it has a positive impact, however others believe that it has a negative one. This essay believes that good sportsman are supposed to earn more due to the fact that their life is in <span style="text-decoration:underline; color:red">a</span> danger. 
      On the one hand, there are numerous people who think that everyone has to get <span style="text-decoration:underline; color:red">the</span> equal salary and it is unfair to someone receives more. Good workers are <span style="text-decoration:underline; color:red">consider</span> to have tremendous money due to the fact that they have a higher position in a company. Also, there are professions connected with <span style="text-decoration:underline; color:red">IT</span> sphere where people can develop and earn more. According to some survey, people who work in such companies complain that they get fewer than those who participate in <span style="text-decoration:underline; color:red">a professional competitions</span>. This essay argues that individuals who have a good job cannot have salary bigger than sportsman due to the fact that they <span style="text-decoration:underline; color:red">always</span> at <span style="text-decoration:underline; color:red">a</span> risk to be injured.
      However, some people are aware of the fact that sportsman work hard to achieve their goals that are related to the fact that they have a desire to win a competition and get a reward. In addition, they have some challenges in their career that is connected with depression or some accidents. That is why people consider their salary to be higher. According to some research, approximately 60% of respondents share that they <span style="text-decoration:underline; color:red">satisfied</span> with their budget.
      In conclusion, currently, there are a large number of people who believe that sportsman deserve to get a big salary due to the fact that they work hard and for our pleasure and fun.
      """;

    final parts = essayContent.split('___');
    final spans = <InlineSpan>[];

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i]));
      if (i < parts.length - 1) {
        spans.add(WidgetSpan(
          child: Container(
            width: 50,
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 2),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              style: TextStyle(
                color: Colors.red,
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
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
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: AppColors.getColor(themeIndex, 'primaryText'),
                  fontSize: 11,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                children: spans,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
