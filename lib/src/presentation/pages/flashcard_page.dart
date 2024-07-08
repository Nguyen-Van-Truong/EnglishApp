// lib/src/presentation/pages/flashcard_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';

class FlashcardPage extends StatefulWidget {
  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  int currentIndex = 0;
  final List<String> words = ['Word 1', 'Word 2', 'Word 3', 'Word 4', 'Word 5'];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        backgroundColor: AppColors.getColor(themeIndex, 'headerBackground'),
        title: Text(
          'FLASHCARD',
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryText'),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildHeader(themeIndex),
          _buildFlashcard(themeIndex),
          _buildNavigationButtons(themeIndex),
        ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(words.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == currentIndex
                      ? AppColors.getColor(themeIndex, 'headerCircle1')
                      : Colors.transparent,
                  border: Border.all(
                    color: index == currentIndex
                        ? AppColors.getColor(themeIndex, 'primaryText')
                        : AppColors.getColor(themeIndex, 'primaryText').withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashcard(int themeIndex) {
    return Expanded(
      child: Center(
        child: Container(
          width: 400,
          height: 595,
          decoration: BoxDecoration(
            color: AppColors.getColor(themeIndex, 'cardBackground'),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
          ),
          child: Stack(
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.volume_up, size: 30, color: AppColors.getColor(themeIndex, 'primaryText')),
                    SizedBox(width: 10),
                    Text(
                      words[currentIndex],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.getColor(themeIndex, 'primaryText'),
                        fontSize: 35,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(int themeIndex) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentIndex = (currentIndex - 1 + words.length) % words.length;
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.getColor(themeIndex, 'primaryText'),
              backgroundColor: AppColors.getColor(themeIndex, 'cardBackground'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
              ),
            ),
            child: Text(
              'Previous',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            '${currentIndex + 1}/${words.length}',
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentIndex = (currentIndex + 1) % words.length;
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.getColor(themeIndex, 'primaryText'),
              backgroundColor: AppColors.getColor(themeIndex, 'cardBackground'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
              ),
            ),
            child: Text(
              'Next',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
