import 'package:englishapp/src/presentation/widgets/lesson_card.dart';
import 'package:englishapp/src/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          LessonCard(
            title: localizations?.translate('introduction') ?? 'Introduction',
            lessonsCount: 6,
            iconLeft: Icons.volume_up,
            iconRight: Icons.arrow_forward,
            iconColor: Colors.orangeAccent,
          ),
          const SizedBox(height: 16),
          LessonCard(
            title: localizations?.translate('vocabulary_grammar') ?? 'Vocabulary & Grammar',
            lessonsCount: 6,
            iconLeft: Icons.book,
            iconRight: Icons.arrow_forward,
            iconColor: Colors.blue,
          ),
          const SizedBox(height: 16),
          LessonCard(
            title: localizations?.translate('listening') ?? 'Listening',
            lessonsCount: 6,
            iconLeft: Icons.headphones,
            iconRight: Icons.arrow_forward,
            iconColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
