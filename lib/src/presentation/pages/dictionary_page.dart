// lib/src/presentation/pages/dictionary_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';

class DictionaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        backgroundColor: AppColors.getColor(themeIndex, 'headerBackground'),
        title: Text(
          'DICTIONARY',
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(context, themeIndex),
            _buildSuggestedWords(context, themeIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, int themeIndex) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 32, // Full width minus padding
        decoration: BoxDecoration(
          color: AppColors.getColor(themeIndex, 'searchDictionaryBackground'),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.search, size: 20, color: AppColors.getColor(themeIndex, 'primaryText')),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Word',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: AppColors.getColor(themeIndex, 'secondaryText')),
                  ),
                  style: TextStyle(color: AppColors.getColor(themeIndex, 'primaryText')),
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: 'Language',
                icon: Icon(Icons.arrow_drop_down, color: AppColors.getColor(themeIndex, 'primaryText')),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: AppColors.getColor(themeIndex, 'primaryText'),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String? newValue) {
                  // Handle language change here
                },
                items: <String>['Language', 'EN', 'FR', 'ES']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedWords(BuildContext context, int themeIndex) {
    final List<String> suggestedWords = [
      'Suggested word 1',
      'Suggested word 2',
      'Suggested word 3',
      'Suggested word 4',
      'Suggested word 5',
      'Suggested word 6',
      'Suggested word 7',
      'Suggested word 8',
      'Suggested word 9',
      'Suggested word 10',
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: suggestedWords.map((word) {
          return Container(
            width: MediaQuery.of(context).size.width - 32, // Full width minus padding
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: AppColors.getColor(themeIndex, 'cardBackground'),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                word,
                style: TextStyle(
                  color: AppColors.getColor(themeIndex, 'primaryText'),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
