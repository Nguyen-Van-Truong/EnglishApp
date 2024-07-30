// lib/src/presentation/pages/vocabulary_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';

class VocabularyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        backgroundColor: AppColors.getColor(themeIndex, 'headerBackground'),
        title: Text(
          'VOCABULARY LIST',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Continue your last study set', 'See all', themeIndex),
            _buildVocabularyRow(['Name 1', 'Name 2', 'Name 3', 'Name 4', 'Name 5'], themeIndex),
            const SizedBox(height: 16),
            _buildSectionHeader('ENGLISH', 'See all', themeIndex),
            _buildVocabularyRow(['IELTS 1', 'IELTS 2', 'TOEIC 1', 'TOEIC 2', 'IELTS 3'], themeIndex),
            const SizedBox(height: 16),
            _buildSectionHeader('CHINESE', 'See all', themeIndex),
            _buildVocabularyRow(['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5'], themeIndex),
            const SizedBox(height: 16),
            _buildSectionHeader('JAPANESE', 'See all', themeIndex),
            _buildVocabularyRow(['N1', 'N2', 'N3', 'N4', 'N5'], themeIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText, int themeIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          actionText,
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'seeAllVocabularyList'),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildVocabularyRow(List<String> titles, int themeIndex) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: titles.map((title) {
          return _buildVocabularyCard(title, 'Short description about set.', 'Image', themeIndex);
        }).toList(),
      ),
    );
  }

  Widget _buildVocabularyCard(String title, String description, String imagePlaceholder, int themeIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      padding: const EdgeInsets.all(16.0),
      width: 250,
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'cardBackground'),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.getColor(themeIndex, 'headerCircle3'),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text(imagePlaceholder)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.getColor(themeIndex, 'primaryText'),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
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
        ],
      ),
    );
  }
}
