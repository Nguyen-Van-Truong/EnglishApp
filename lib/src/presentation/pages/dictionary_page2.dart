import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFDBA6),
        title: Text(
          'Word',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.volume_up, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.25)),
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
                        _buildTab('ENG - VIET', isEngVietTab),
                        _buildTab('GRAMMAR', !isEngVietTab),
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

  Widget _buildTab(String title, bool isSelected) {
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
                color: isSelected ? Colors.black : Colors.black.withOpacity(0.5),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ),
          Container(
            height: 2,
            color: isSelected ? Colors.black : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
