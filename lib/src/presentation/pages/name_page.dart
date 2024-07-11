// lib/src/presentation/pages/name_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';

class NamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        backgroundColor: AppColors.getColor(themeIndex, 'headerBackground'),
        title: Text(
          'NAME',
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
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
            _buildHeader(themeIndex),
            _buildMainCard(themeIndex),
            _buildBottomCard(themeIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int themeIndex) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'headerBackground'),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(9, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 0
                        ? AppColors.getColor(themeIndex, 'headerCircle1')
                        : Colors.transparent,
                    border: Border.all(
                      color: index == 0
                          ? AppColors.getColor(themeIndex, 'primaryTextHeader')
                          : AppColors.getColor(themeIndex, 'primaryTextHeader')
                          .withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCard(int themeIndex) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      width: 400,
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'cardBackground'),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '“Can I try some?” he asked, and the _______ beside the cake, clutching his floppy wet chef\'s hat, merely shrugged.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            _buildOption('knight', true, themeIndex),
            _buildOption('monarch', true, themeIndex),
            _buildOption('prophet', false, themeIndex),
            _buildOption('baker', true, themeIndex),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTag('Definition', themeIndex),
                const SizedBox(width: 8),
                _buildTag('Suggestion', themeIndex),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Describe definition/Suggestion',
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

  Widget _buildOption(String text, bool isCorrect, int themeIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCorrect
                  ? AppColors.getColor(themeIndex, 'cardBackground')
                  : AppColors.getColor(themeIndex, 'headerCircle2'),
              border: Border.all(
                width: 3,
                color: isCorrect
                    ? AppColors.getColor(themeIndex, 'headerCircle1')
                    : AppColors.getColor(themeIndex, 'headerCircle2'),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, int themeIndex) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'cardBackground'),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.getColor(themeIndex, 'primaryText'),
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildBottomCard(int themeIndex) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      width: 400,
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'cardBackground'),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Well done! ',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'headerCircle1'),
                      fontSize: 23,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: '/',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 23,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' Try again!',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'messageBotBackground'),
                      fontSize: 23,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Solve the question and give brief describe',
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
}
