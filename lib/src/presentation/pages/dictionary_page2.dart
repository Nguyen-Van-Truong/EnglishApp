// lib/src/presentation/pages/dictionary_page2.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';
import '../widgets/eng_viet_tab.dart';
import '../widgets/grammar_tab.dart';

class DictionaryPage2 extends StatefulWidget {
  @override
  _DictionaryPage2State createState() => _DictionaryPage2State();
}

class _DictionaryPage2State extends State<DictionaryPage2> {
  bool isEngVietTab = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        backgroundColor: AppColors.getColor(themeIndex, 'headerBackground'),
        title: Text(
          'Word',
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
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.volume_up, size: 30, color: AppColors.getColor(themeIndex, 'primaryText')),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.getColor(themeIndex, 'cardBackground'),
              border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        _buildTab('ENG - VIET', isEngVietTab, themeIndex),
                        _buildTab('GRAMMAR', !isEngVietTab, themeIndex),
                      ],
                    ),
                  ],
                ),
                if (isEngVietTab) EngVietTab() else GrammarTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected, int themeIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEngVietTab = (title == 'ENG - VIET');
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? AppColors.getColor(themeIndex, 'primaryText') : AppColors.getColor(themeIndex, 'primaryText').withOpacity(0.5),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ),
          Container(
            height: 2,
            color: isSelected ? AppColors.getColor(themeIndex, 'primaryText') : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
