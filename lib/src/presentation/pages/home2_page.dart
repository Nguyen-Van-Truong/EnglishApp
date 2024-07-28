// lib/src/presentation/pages/home2_page.dart
import 'package:englishapp/src/presentation/pages/chatbot_page.dart';
import 'package:englishapp/src/presentation/pages/check_spelling_error_page.dart';
import 'package:englishapp/src/presentation/pages/dictionary_page.dart';
import 'package:englishapp/src/presentation/pages/exam_page.dart';
import 'package:englishapp/src/presentation/pages/flashcard_page.dart';
import 'package:englishapp/src/presentation/pages/gradle_writing_exam_page.dart';
import 'package:englishapp/src/presentation/pages/learn_page.dart';
import 'package:englishapp/src/presentation/pages/practice_page.dart';
import 'package:englishapp/src/presentation/pages/virtual_speaking_room.dart';
import 'package:englishapp/src/theme/colors.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/utils/app_localizations.dart';

import '../widgets/flash_sale_section.dart';
import '../widgets/suggestion_section.dart';

class Home2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;
    final localization = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(themeIndex, localization),
                const SizedBox(height: 16),
                FlashSaleSection(),
                const SizedBox(height: 16),
                SuggestionSection(),
                const SizedBox(height: 16),
                _buildChatbotSection(themeIndex, localization),
                const SizedBox(height: 16),
                _buildMainSections(context, themeIndex, localization),
              ],
            ),
          ),
          _buildChatBubbles(context, themeIndex),
        ],
      ),
    );
  }

  Widget _buildHeader(int themeIndex, AppLocalizations? localization) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.getColor(themeIndex, 'headerBackgroundGradient2Home'),
            AppColors.getColor(themeIndex, 'headerBackgroundGradient1Home'),
            AppColors.getColor(themeIndex, 'headerBackgroundGradient2Home')
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization?.translate('welcome_back') ?? 'Welcome back,',
                  style: TextStyle(
                    color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  localization?.translate('username') ?? 'Username',
                  style: TextStyle(
                    color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 16,
            top: 25,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Text(
                'Logo App',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            right: -30,
            top: 50,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.getColor(themeIndex, 'headerCircle3'),
                shape: BoxShape.circle,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  localization?.translate('chatbot_character') ?? 'Chatbot Character',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatbotSection(int themeIndex, AppLocalizations? localization) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.getColor(themeIndex, 'cardBackground'),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.getColor(themeIndex, 'border')),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization?.translate('imta_chatbot') ?? 'IMTA ChatBot',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add your onTap logic here
                    },
                    child: Text(
                      localization?.translate('view_history') ?? 'View History',
                      style: TextStyle(
                        color: AppColors.getColor(themeIndex, 'primaryText'),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Replace with the actual number of items
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 8.0),
                    decoration: BoxDecoration(
                      color: AppColors.getColor(themeIndex, 'cardChatBot'),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.getColor(themeIndex, 'border')),
                    ),
                    child: Center(
                      child: index == 0
                          ? Icon(Icons.add, color: AppColors.getColor(themeIndex, 'primaryText'), size: 24)
                          : Text(
                        'Chat $index',
                        style: TextStyle(
                          color: AppColors.getColor(themeIndex, 'primaryText'),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainSections(BuildContext context, int themeIndex, AppLocalizations? localization) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization?.translate('what_should_we_do_today') ?? 'What should we do today?',
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          _buildCard(context, localization?.translate('grade_writing_exam') ?? 'Grade Writing Exam', 'lib/res/assets/icon_app/icon_Grade_Writing_Exam.png', themeIndex, GradeWritingExam()),
          _buildCard(context, localization?.translate('study_by_topic') ?? 'Study by Topic', 'lib/res/assets/icon_app/Study_by_Topic.png', themeIndex, const LearnPage()),
          _buildCard(context, localization?.translate('solve_exercise') ?? 'Solve Exercise', 'lib/res/assets/icon_app/Solve_Exercise.png', themeIndex, ChatbotPage()),
          _buildCard(context, localization?.translate('check_spelling_error') ?? 'Check Spelling Error', 'lib/res/assets/icon_app/Check_Spelling_Error.png', themeIndex, CheckSpellingErrorPage()),
          _buildCard(context, localization?.translate('flashcard') ?? 'Flashcard', 'lib/res/assets/icon_app/Flashcard.png', themeIndex, FlashcardPage()),
          _buildCard(context, localization?.translate('dictionary') ?? 'Dictionary', 'lib/res/assets/icon_app/Dictionary.png', themeIndex, DictionaryPage()),
          _buildCard(context, localization?.translate('virtual_speaking_room') ?? 'Virtual Speaking Room', 'lib/res/assets/icon_app/Virtual_Speaking_Room.png', themeIndex, VirtualSpeakingRoom()),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String iconPath, int themeIndex, Widget targetPage) {
    return Card(
      color: AppColors.getColor(themeIndex, 'cardBackground'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryText'),
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: Image.asset(
            iconPath,
            width: 24,
            height: 24,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
      ),
    );
  }

  Widget _buildChatBubbles(BuildContext context, int themeIndex) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTopChatBubble(themeIndex),
          const SizedBox(height: 8),
          _buildBottomChatBubble(context, themeIndex),
        ],
      ),
    );
  }

  Widget _buildTopChatBubble(int themeIndex) {
    String numberText = '0'; // Replace this with the actual dynamic value
    double containerSize = (numberText.length * 8.0).clamp(16.0, 24.0); // Adjust size based on length

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'chatBubbleBackground'),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'lib/res/assets/icon_app/icon_fire.png',
            width: 24,
            height: 24,
          ),
          Positioned(
            right: 6,
            top: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  numberText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomChatBubble(BuildContext context, int themeIndex) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatbotPage()),
        );
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.getColor(themeIndex, 'chatBubbleBackground'),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(
          'lib/res/assets/icon_app/icon_chatbot.png',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
