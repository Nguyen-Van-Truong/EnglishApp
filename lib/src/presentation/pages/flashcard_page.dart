// lib/src/presentation/pages/flashcard_page.dart
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';

class Flashcard {
  final String englishWord;
  final String vietnameseMeaning;

  Flashcard({required this.englishWord, required this.vietnameseMeaning});

  Map<String, String> toJson() => {
    'englishWord': englishWord,
    'vietnameseMeaning': vietnameseMeaning,
  };

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      englishWord: json['englishWord'],
      vietnameseMeaning: json['vietnameseMeaning'],
    );
  }
}

class FlashcardPage extends StatefulWidget {
  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  int currentIndex = 0;
  List<Flashcard> flashcards = [];

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/flashcards.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final List<dynamic> loadedFlashcards = json.decode(jsonData);
      setState(() {
        flashcards = loadedFlashcards
            .map((flashcardJson) => Flashcard.fromJson(flashcardJson))
            .toList();
      });
    } else {
      flashcards = [];
      _saveFlashcards();
    }
  }

  Future<void> _saveFlashcards() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/flashcards.json');
    await file.writeAsString(
        json.encode(flashcards.map((fc) => fc.toJson()).toList()));
  }

  void _addFlashcard(String englishWord, String vietnameseMeaning) {
    setState(() {
      flashcards.add(Flashcard(
          englishWord: englishWord, vietnameseMeaning: vietnameseMeaning));
      if (flashcards.length == 1) {
        // Khi thêm flashcard đầu tiên, đặt currentIndex về 0
        currentIndex = 0;
      }
    });
    _saveFlashcards();
  }

  void _deleteFlashcard(int index) {
    setState(() {
      flashcards.removeAt(index);
      if (currentIndex >= flashcards.length) {
        currentIndex = flashcards.length - 1;
      }
    });
    _saveFlashcards();
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
          'FLASHCARD',
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
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddFlashcardDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(themeIndex),
          _buildFlashcard(themeIndex),
          _buildNavigationButtons(themeIndex),
          _buildDeleteButton(themeIndex),
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
            children: List.generate(flashcards.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == currentIndex
                      ? AppColors.getColor(themeIndex, 'headerCircle4')
                      : Colors.transparent,
                  border: Border.all(
                    color: index == currentIndex
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
            border: Border.all(
              color: AppColors.getColor(themeIndex, 'secondaryText')
                  .withOpacity(0.25),
            ),
          ),
          child: flashcards.isNotEmpty
              ? Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      flashcards[currentIndex].englishWord,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.getColor(themeIndex, 'primaryText'),
                        fontSize: 35,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      flashcards[currentIndex].vietnameseMeaning,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.getColor(themeIndex, 'secondaryText'),
                        fontSize: 25,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
              : Center(child: Text("No Flashcards")),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(int themeIndex) {
    final isPreviousEnabled = flashcards.isNotEmpty && currentIndex > 0;
    final isNextEnabled = flashcards.isNotEmpty && currentIndex < flashcards.length - 1;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: isPreviousEnabled
                ? () {
              setState(() {
                currentIndex = (currentIndex - 1) % flashcards.length;
              });
            }
                : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: isPreviousEnabled
                  ? AppColors.getColor(themeIndex, 'primaryText')
                  : Colors.grey,
              backgroundColor: AppColors.getColor(themeIndex, 'cardBackground'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isPreviousEnabled
                      ? AppColors.getColor(themeIndex, 'secondaryText')
                      .withOpacity(0.25)
                      : Colors.grey.withOpacity(0.25),
                ),
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
            flashcards.isNotEmpty
                ? '${currentIndex + 1}/${flashcards.length}'
                : '0/0',
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: isNextEnabled
                ? () {
              setState(() {
                currentIndex = (currentIndex + 1) % flashcards.length;
              });
            }
                : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: isNextEnabled
                  ? AppColors.getColor(themeIndex, 'primaryText')
                  : Colors.grey,
              backgroundColor: AppColors.getColor(themeIndex, 'cardBackground'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isNextEnabled
                      ? AppColors.getColor(themeIndex, 'secondaryText')
                      .withOpacity(0.25)
                      : Colors.grey.withOpacity(0.25),
                ),
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

  Widget _buildDeleteButton(int themeIndex) {
    return flashcards.isNotEmpty
        ? Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          _deleteFlashcard(currentIndex);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          'Delete Flashcard',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    )
        : Container();
  }

  void _showAddFlashcardDialog(BuildContext context) {
    TextEditingController englishController = TextEditingController();
    TextEditingController vietnameseController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Flashcard'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: englishController,
                decoration: InputDecoration(hintText: 'Enter English word'),
              ),
              TextField(
                controller: vietnameseController,
                decoration: InputDecoration(hintText: 'Enter Vietnamese meaning'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (englishController.text.isNotEmpty &&
                    vietnameseController.text.isNotEmpty) {
                  _addFlashcard(englishController.text,
                      vietnameseController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
