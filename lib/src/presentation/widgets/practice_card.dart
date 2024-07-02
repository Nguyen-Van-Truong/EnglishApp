import 'package:englishapp/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';

class PracticeCard extends StatelessWidget {
  final String title;
  final int exercisesCount;
  final IconData icon;
  final Color iconColor;

  const PracticeCard({
    Key? key,
    required this.title,
    required this.exercisesCount,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      color: AppColors.getColor(themeIndex, 'cardBackground'), // Sử dụng màu nền từ AppColors
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(icon, size: 30, color: iconColor),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.getColor(themeIndex, 'primaryText'), // Sử dụng màu chữ từ AppColors
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$exercisesCount exercises',
              style: TextStyle(color: AppColors.getColor(themeIndex, 'secondaryText'), fontSize: 16),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.0,
              backgroundColor: Colors.grey[300],
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
