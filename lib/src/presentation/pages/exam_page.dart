import 'package:englishapp/src/presentation/pages/home2_page.dart';
import 'package:flutter/material.dart';
import 'package:englishapp/src/presentation/pages/chatbot_page.dart';
import 'package:englishapp/src/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/presentation/widgets/exam_card.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        title: const Text('Shortcuts'),
        backgroundColor: AppColors.getColor(themeIndex, 'navigationBarBackground'),
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
          ],
        ),
      ),
    );
  }
}
