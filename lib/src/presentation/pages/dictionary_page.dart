import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';

class DictionaryPage extends StatefulWidget {
  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  String word = '';
  Map<String, dynamic>? dictionaryData;
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchWordDefinition(String query) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$query';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          dictionaryData = json.decode(response.body)[0];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Word not found. Please try again.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load data. Please check your internet connection.';
        isLoading = false;
      });
    }
  }

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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(context, themeIndex),
            if (isLoading) CircularProgressIndicator(),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(errorMessage, style: TextStyle(color: Colors.red)),
              ),
            if (dictionaryData != null) _buildWordDetails(themeIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, int themeIndex) {
    TextEditingController searchController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
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
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for a word...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: AppColors.getColor(themeIndex, 'secondaryText')),
                  ),
                  style: TextStyle(color: AppColors.getColor(themeIndex, 'primaryText')),
                  onSubmitted: (query) {
                    setState(() {
                      word = query;
                    });
                    fetchWordDefinition(query);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWordDetails(int themeIndex) {
    final phonetics = dictionaryData?['phonetics'] ?? [];
    final meanings = dictionaryData?['meanings'] ?? [];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dictionaryData?['word'] ?? '',
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 28,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (phonetics.isNotEmpty) ..._buildPhonetics(themeIndex, phonetics),
          const SizedBox(height: 16),
          if (meanings.isNotEmpty) ..._buildMeanings(themeIndex, meanings),
        ],
      ),
    );
  }

  List<Widget> _buildPhonetics(int themeIndex, List<dynamic> phonetics) {
    return phonetics
        .map(
          (phonetic) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          phonetic['text'] ?? '',
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'secondaryText'),
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    )
        .toList();
  }

  List<Widget> _buildMeanings(int themeIndex, List<dynamic> meanings) {
    return meanings
        .map(
          (meaning) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meaning['partOfSpeech'] ?? '',
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            ...meaning['definitions'].map<Widget>((definition) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      definition['definition'] ?? '',
                      style: TextStyle(
                        color: AppColors.getColor(themeIndex, 'secondaryText'),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    if (definition['example'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Example: ${definition['example']}',
                          style: TextStyle(
                            color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.8),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    )
        .toList();
  }
}
