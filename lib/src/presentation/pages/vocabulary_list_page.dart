// lib/src/presentation/pages/vocabulary_list_page.dart
import 'package:flutter/material.dart';

class VocabularyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFDBA6),
        title: Text(
          'VOCABULARY LIST',
          style: TextStyle(
            color: Colors.white,
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
            _buildSectionHeader('Continue your last study set', 'See all'),
            _buildVocabularyRow(['Name 1', 'Name 2', 'Name 3', 'Name 4', 'Name 5']),
            const SizedBox(height: 16),
            _buildSectionHeader('ENGLISH', 'See all'),
            _buildVocabularyRow(['IELTS 1', 'IELTS 2', 'TOEIC 1', 'TOEIC 2', 'IELTS 3']),
            const SizedBox(height: 16),
            _buildSectionHeader('CHINESE', 'See all'),
            _buildVocabularyRow(['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5']),
            const SizedBox(height: 16),
            _buildSectionHeader('JAPANESE', 'See all'),
            _buildVocabularyRow(['N1', 'N2', 'N3', 'N4', 'N5']),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          actionText,
          style: TextStyle(
            color: Color(0xFF9943FE),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildVocabularyRow(List<String> titles) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: titles.map((title) {
          return _buildVocabularyCard(title, 'Short description about set.', 'Image');
        }).toList(),
      ),
    );
  }

  Widget _buildVocabularyCard(String title, String description, String imagePlaceholder) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      padding: const EdgeInsets.all(16.0),
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
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
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.black,
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
