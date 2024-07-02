import 'package:englishapp/src/presentation/widgets/practice_card.dart';
import 'package:englishapp/src/theme/colors.dart';
import 'package:englishapp/src/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'), // Sử dụng màu nền từ AppColors
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: PracticeCard(
                    title: localizations?.translate('vocabulary') ?? 'Vocabulary',
                    exercisesCount: 3,
                    icon: Icons.book,
                    iconColor: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PracticeCard(
                    title: localizations?.translate('spell_check') ?? 'Spell Check',
                    exercisesCount: 2,
                    icon: Icons.spellcheck,
                    iconColor: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PracticeCard(
                    title: localizations?.translate('listening') ?? 'Listening',
                    exercisesCount: 1,
                    icon: Icons.headphones,
                    iconColor: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PracticeCard(
                    title: localizations?.translate('reading') ?? 'Reading',
                    exercisesCount: 1,
                    icon: Icons.chrome_reader_mode,
                    iconColor: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PracticeCard(
                    title: localizations?.translate('writing') ?? 'Writing',
                    exercisesCount: 1,
                    icon: Icons.edit,
                    iconColor: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(), // Placeholder for balance
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
