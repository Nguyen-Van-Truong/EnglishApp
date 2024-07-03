// lib/src/presentation/pages/vocabulary_name_page.dart
import 'package:flutter/material.dart';

class VocabularyNamePage extends StatefulWidget {
  @override
  _VocabularyNamePageState createState() => _VocabularyNamePageState();
}

class _VocabularyNamePageState extends State<VocabularyNamePage> {
  final PageController _pageController = PageController(
    initialPage: 1000, // Đặt giá trị cao để tạo hiệu ứng vòng lặp
    viewportFraction: 0.8,
  );

  final List<String> words = [
    'Word 1', 'Word 2', 'Word 3', 'Word 4', 'Word 5'
  ];

  String dropdownValue = 'Original';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFDBA6),
        title: Text(
          'VOCABULARY NAME',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFlashcardSlider(),
            const SizedBox(height: 16),
            _buildUserInfo(),
            const SizedBox(height: 16),
            _buildOption('Flashcard', Icons.flash_on),
            const SizedBox(height: 16),
            _buildOption('Learn', Icons.book),
            const SizedBox(height: 16),
            _buildOption('Test', Icons.quiz),
            const SizedBox(height: 16),
            _buildTermsHeader(),
            const SizedBox(height: 8),
            _buildTermCard('Word 1', 'Definition 1'),
            _buildTermCard('Word 2', 'Definition 2'),
            _buildTermCard('Word 3', 'Definition 3'),
            _buildTermCard('Word 4', 'Definition 4'),
            const SizedBox(height: 16),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFlashcardSlider() {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          final wordIndex = index % words.length;
          return _buildFlashcard(words[wordIndex]);
        },
      ),
    );
  }

  Widget _buildFlashcard(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 250,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.25)),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.zoom_out_map, size: 30),
              onPressed: () {
                // Thêm logic phóng to thẻ từ
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFD9D9D9),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black.withOpacity(0.25)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Role',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.25),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '91 terms',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOption(String title, IconData icon) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          SizedBox(width: 16),
          Icon(icon, size: 30),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Terms',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          underline: Container(
            height: 2,
            color: Colors.black.withOpacity(0.25),
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Original', 'Alphabetically']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTermCard(String word, String definition) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      height: 127,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    word,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    definition,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.volume_up),
              onPressed: () {
                // Thêm logic phát âm từ
              },
            ),
            IconButton(
              icon: Icon(Icons.star_border),
              onPressed: () {
                // Thêm logic đánh dấu từ yêu thích
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      width: double.infinity,
      color: Color(0xFFFFDBB0),
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF9900),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Study this set',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
