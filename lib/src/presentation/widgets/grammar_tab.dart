import 'package:flutter/material.dart';

class GrammarTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSectionContainer(
          title: 'Family words',
          children: [
            _buildWordCategory('Noun', ['Word 1', 'Word 2', 'Word 3']),
            _buildWordCategory('Verb', ['Word 1', 'Word 2', 'Word 3']),
            _buildWordCategory('Adjective', ['Word 1', 'Word 2', 'Word 3']),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionContainer(
          title: 'Tense',
          children: [
            _buildWordCategory('Past', ['Word 1']),
            _buildWordCategory('Past Participant (P2)', ['Word 1']),
            _buildWordCategory('V-ing', ['Word 1']),
            _buildWordCategory('Present', ['Word 1']),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildWordCategory(String category, List<String> words) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.play_arrow,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                category,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (var word in words) _buildWordItem(word),
        ],
      ),
    );
  }

  Widget _buildWordItem(String word) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
      child: Text(
        word,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
