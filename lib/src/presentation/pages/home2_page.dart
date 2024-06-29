import 'package:englishapp/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/presentation/widgets/icon_widget.dart';
import 'package:englishapp/src/theme/theme_provider.dart';

class Home2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isPinkTheme = themeProvider.themeIndex == 1;

    return Scaffold(
      backgroundColor: isPinkTheme ? AppColors.pageBackgroundPink : AppColors.pageBackground,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isPinkTheme),
                SizedBox(height: 16),
                _buildChatbotSection(isPinkTheme),
                SizedBox(height: 16),
                _buildMainSections(isPinkTheme),
              ],
            ),
          ),
          _buildChatBubbles(isPinkTheme),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isPinkTheme) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPinkTheme ? [AppColors.headerBackgroundPink, AppColors.headerCircle2Pink, AppColors.headerBackgroundPink] : [AppColors.headerBackground, Color(0xFFFF0099), AppColors.headerBackground],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.vertical(
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
                  'Welcome back,',
                  style: TextStyle(
                    color: isPinkTheme ? AppColors.primaryTextPink : AppColors.primaryText,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Username',
                  style: TextStyle(
                    color: isPinkTheme ? AppColors.primaryTextPink : AppColors.primaryText,
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
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
                color: isPinkTheme ? AppColors.headerCircle3Pink : AppColors.headerCircle3,
                shape: BoxShape.circle,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Nhân vật\nChatbot',
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

  Widget _buildChatbotSection(bool isPinkTheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: isPinkTheme ? AppColors.cardBackgroundPink : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
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
                    'IMTA ChatBot',
                    style: TextStyle(
                      color: isPinkTheme ? AppColors.primaryTextPink : AppColors.primaryText,
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
                      'View History',
                      style: TextStyle(
                        color: isPinkTheme ? AppColors.primaryTextPink : AppColors.primaryText,
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
            SizedBox(height: 8),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Replace with the actual number of items
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF47048A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: index == 0
                          ? Icon(Icons.add, color: isPinkTheme ? AppColors.primaryTextPink : AppColors.primaryText, size: 24)
                          : Text(
                        'Chat $index',
                        style: TextStyle(
                          color: isPinkTheme ? AppColors.primaryTextPink : AppColors.primaryText,
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

  Widget _buildMainSections(bool isPinkTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What should we do today?',
            style: TextStyle(
              color: isPinkTheme ? AppColors.primaryTextPink : AppColors.primaryText,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          _buildCard('Grade Writing Exam', 'lib/res/assets/icon_app/icon_Grade_Writing_Exam.png', isPinkTheme),
          _buildCard('Study by Topic', 'lib/res/assets/icon_app/Study_by_Topic.png', isPinkTheme),
          _buildCard('Solve Exercise', 'lib/res/assets/icon_app/Solve_Exercise.png', isPinkTheme),
          _buildCard('Check Spelling Error', 'lib/res/assets/icon_app/Check_Spelling_Error.png', isPinkTheme),
          _buildCard('Flashcard', 'lib/res/assets/icon_app/Flashcard.png', isPinkTheme),
          _buildCard('Dictionary', 'lib/res/assets/icon_app/Dictionary.png', isPinkTheme),
          _buildCard('Virtual Speaking Room', 'lib/res/assets/icon_app/Virtual_Speaking_Room.png', isPinkTheme),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String iconPath, bool isPinkTheme) {
    return Card(
      color: isPinkTheme ? AppColors.cardBackgroundPink : AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.white, width: 2),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: isPinkTheme ? AppColors.primaryTextPink : AppColors.primaryText,
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
      ),
    );
  }

  Widget _buildChatBubbles(bool isPinkTheme) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTopChatBubble(isPinkTheme),
          SizedBox(height: 8),
          _buildBottomChatBubble(isPinkTheme),
        ],
      ),
    );
  }

  Widget _buildTopChatBubble(bool isPinkTheme) {
    String numberText = '0'; // Replace this with the actual dynamic value
    double containerSize = (numberText.length * 8.0).clamp(16.0, 24.0); // Adjust size based on length

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isPinkTheme ? AppColors.cardBackgroundPink : Color(0xFF1B003D),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
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
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              height: 20,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  numberText,
                  style: TextStyle(
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

  Widget _buildBottomChatBubble(bool isPinkTheme) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isPinkTheme ? AppColors.cardBackgroundPink : Color(0xFF1B003D),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Image.asset(
        'lib/res/assets/icon_app/icon_chatbot.png',
        width: 24,
        height: 24,
      ),
    );
  }
}
