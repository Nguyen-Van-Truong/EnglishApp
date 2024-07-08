import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';

class GradeWritingExam extends StatelessWidget {
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
            color: AppColors.getColor(themeIndex, 'primaryText'),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildEssayTopicSection(themeIndex),
            const SizedBox(height: 0),
            _buildScoreSection(themeIndex),
            const SizedBox(height: 0),
            _buildEssayContentSection(themeIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreSection(int themeIndex) {
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
            Row(
              children: [
                Text(
                  '4.5',
                  style: TextStyle(
                    color: AppColors.getColor(themeIndex, 'headerCircle1'),
                    fontSize: 60,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScoreItem('Coherence & Cohesion: 4.0', themeIndex),
                      _buildScoreItem('Lexical Resources: 4.0', themeIndex),
                      _buildScoreItem('Grammatical range: 4.0', themeIndex),
                      _buildScoreItem('Task Achievement: 5.0', themeIndex),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Overall Band Score',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
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
          Text(
            text,
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 10,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
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
              'Successful sports professionals can earn a lot of money than people in other important professions, some people thinks that this is fully justified while others think it is unfair. Discuss both sides and give your opinion.',
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
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'In ',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'the',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'messageBotBackground'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: ' modern-day society, professional ',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'sportsman',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'messageBotBackground'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: ' get a big salary ',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'compare',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'messageBotBackground'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: ' with ',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'others',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'messageBotBackground'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: ' people who are related to ',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'another significant jobs',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'messageBotBackground'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text:
                    '. Some individuals think that it has a positive impact, however others believe that it has a negative one. This essay believes that good sportsman are supposed to earn more due to the fact that their life is in ',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'a',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'messageBotBackground'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text:
                    ' danger. \nOn the one hand, there are numerous people who think that everyone has to get ',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'the',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'messageBotBackground'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text:
                    ' equal salary and it is unfair to someone receives more. Good workers are consider to have tremendous money due to the fact that they have a higher position in a company. Also, there are professions connected with ',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'IT',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'messageBotBackground'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text:
                    ' sphere where people can develop and earn more. According to some survey, people who work in such companies complain that they get fewer than those who participate in a professional competitions. This essay argues that individuals who have a good job cannot have salary bigger than sportsman due to the fact that they always at a risk to be injured.\nHowever, some people are aware of the fact that sportsman work hard to achieve their goals that are related to the fact that they have a desire to win a competition and get a reward. In addition, they have some challenges in their career that is connected with depression or some accidents. That is why people consider their salary to be higher. According to some research, approximately 60% of respondents share that they satisfied with their budget.\nIn conclusion, currently, there are a large number of people who believe that sportsman deserve to get a big salary due to the fact that they work hard and for our pleasure and fun.',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
