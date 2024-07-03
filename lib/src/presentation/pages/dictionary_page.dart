import 'package:flutter/material.dart';

class DictionaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFDBA6),
        title: Text(
          'DICTIONARY',
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
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildSuggestedWords(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 32, // Full width minus padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.25)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.search, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Word',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: 'Language',
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: Colors.black,
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

  Widget _buildSuggestedWords(BuildContext context) {
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black.withOpacity(0.25)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                word,
                style: TextStyle(
                  color: Colors.black,
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
