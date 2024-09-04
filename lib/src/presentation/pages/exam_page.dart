// lib/src/presentation/pages/exam_page.dart
import 'package:englishapp/src/presentation/pages/dictionary_page.dart';
import 'package:englishapp/src/presentation/pages/dictionary_page2.dart';
import 'package:englishapp/src/presentation/pages/flashcard_page.dart';
import 'package:englishapp/src/presentation/pages/gradle_writing_exam_page.dart';
import 'package:englishapp/src/presentation/pages/home2_page.dart';
import 'package:englishapp/src/presentation/pages/name_page.dart';
import 'package:englishapp/src/presentation/pages/profile_page.dart';
import 'package:englishapp/src/presentation/pages/room_setup_page.dart';
import 'package:englishapp/src/presentation/pages/virtual_speaking_room.dart';
import 'package:englishapp/src/presentation/pages/vocabulary_list_page.dart';
import 'package:englishapp/src/presentation/pages/vocabulary_name_page.dart';
import 'package:flutter/material.dart';
import 'package:englishapp/src/presentation/pages/chatbot_page.dart';
import 'package:englishapp/src/theme/colors.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/presentation/widgets/exam_card.dart';

class ExamPage extends StatelessWidget {
  final MediaStream? localStream; // Nhận localStream như một tham số
  const ExamPage({super.key, this.localStream});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        title: const Text('Shortcuts'),
        backgroundColor:
        AppColors.getColor(themeIndex, 'navigationBarBackground'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ExamCard(
              title: 'Home Page',
              exercisesCount: 0,
              icon: Icons.home,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home2()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'Chatbot Page',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatbotPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'Room Setup Page',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoomSetupPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'Profile1',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'Vocabulary list',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VocabularyListPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'Vocabulary Name',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VocabularyNamePage()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'FlashCard',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlashcardPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'Name',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NamePage()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'DICTIONARY',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DictionaryPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'DICTIONARY2',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DictionaryPage2()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'Gradle Writing Exam',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GradeWritingExam()),
                );
              },
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: 'Virtual Speaking Room',
              exercisesCount: 0,
              icon: Icons.chat,
              iconColor: Colors.blueAccent,
              onTap: () {
                if (localStream != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VirtualSpeakingRoom(
                        localStream: localStream!,
                        isCameraOn: true,
                        isMicOn: true,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'No local stream available. Please check camera and microphone settings.',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
