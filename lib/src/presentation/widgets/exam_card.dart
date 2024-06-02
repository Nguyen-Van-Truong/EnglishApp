import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  final String title;
  final int exercisesCount;
  final IconData icon;
  final Color iconColor;

  const ExamCard({
    Key? key,
    required this.title,
    required this.exercisesCount,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(icon, size: 30, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('$exercisesCount exercises', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.0,
                    backgroundColor: Colors.grey[300],
                    color: iconColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
