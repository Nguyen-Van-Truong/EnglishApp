import 'package:englishapp/src/presentation/widgets/exam_card.dart';
import 'package:englishapp/src/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ExamCard(
              title: localizations?.translate('exam_images') ?? 'Exam with Images',
              exercisesCount: 5,
              icon: Icons.image,
              iconColor: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            ExamCard(
              title: localizations?.translate('ielts_task_2') ?? 'IELTS Writing Task 2',
              exercisesCount: 3,
              icon: Icons.edit,
              iconColor: Colors.blueAccent,
            ),
            // Add more ExamCards if needed
          ],
        ),
      ),
    );
  }
}
