import 'package:englishapp/src/theme/colors.dart';
import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  final String title;
  final int lessonsCount;
  final IconData iconLeft;
  final IconData iconRight;
  final Color iconColor;

  const LessonCard({
    Key? key,
    required this.title,
    required this.lessonsCount,
    required this.iconLeft,
    required this.iconRight,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      color: AppColors.cardBackground, // Sử dụng màu nền từ AppColors
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(iconLeft, size: 30, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText, // Sử dụng màu chữ từ AppColors
                    ),
                  ),
                  Text(
                    '$lessonsCount lessons',
                    style: TextStyle(
                      color: AppColors.secondaryText, // Sử dụng màu chữ phụ từ AppColors
                    ),
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
            const SizedBox(width: 16),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    iconColor.withOpacity(0.8),
                    iconColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(iconRight, size: 30, color: Colors.white), // Mũi tên màu trắng
              ),
            ),
          ],
        ),
      ),
    );
  }
}
