import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        backgroundColor: AppColors.getColor(themeIndex, 'headerBackground'),
        title: Text(
          'VOCABULARY NAME',
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
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
            _buildFlashcardSlider(themeIndex),
            const SizedBox(height: 16),
            _buildUserInfo(themeIndex),
            const SizedBox(height: 16),
            _buildOption('Flashcard', 'lib/res/assets/icon_app/icFlashcard.png', themeIndex),
            const SizedBox(height: 16),
            _buildOption('Learn', 'lib/res/assets/icon_app/icLearn.png', themeIndex),
            const SizedBox(height: 16),
            _buildOption('Test', 'lib/res/assets/icon_app/icTest.png', themeIndex),
            const SizedBox(height: 16),
            _buildTermsHeader(themeIndex),
            const SizedBox(height: 8),
            _buildTermCard('Word 1', 'Definition 1', themeIndex),
            _buildTermCard('Word 2', 'Definition 2', themeIndex),
            _buildTermCard('Word 3', 'Definition 3', themeIndex),
            _buildTermCard('Word 4', 'Definition 4', themeIndex),
            const SizedBox(height: 16),
            _buildFooter(themeIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildFlashcardSlider(int themeIndex) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          final wordIndex = index % words.length;
          return _buildFlashcard(words[wordIndex], themeIndex);
        },
      ),
    );
  }

  Widget _buildFlashcard(String text, int themeIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 250,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'cardBackground'),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
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
              icon: Icon(Icons.zoom_out_map, size: 30, color: AppColors.getColor(themeIndex, 'primaryText')),
              onPressed: () {
                // Thêm logic phóng to thẻ từ
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(int themeIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.getColor(themeIndex, 'headerCircle3'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: TextStyle(
                    color: AppColors.getColor(themeIndex, 'primaryText'),
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
                        color: AppColors.getColor(themeIndex, 'cardBackground'),
                        border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Role',
                        style: TextStyle(
                          color: AppColors.getColor(themeIndex, 'secondaryText'),
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
                        color: AppColors.getColor(themeIndex, 'primaryText'),
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

  Widget _buildOption(String title, String iconPath, int themeIndex) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'cardBackground'),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
      ),
      child: Row(
        children: [
          SizedBox(width: 16),
          Image.asset(iconPath, width: 30, height: 30),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsHeader(int themeIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Terms',
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryText'),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_drop_down, color: AppColors.getColor(themeIndex, 'primaryText')),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryText'),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          underline: Container(
            height: 2,
            color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25),
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

  Widget _buildTermCard(String word, String definition, int themeIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      height: 127,
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'cardBackground'),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
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
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    definition,
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.volume_up, color: AppColors.getColor(themeIndex, 'primaryText')),
              onPressed: () {
                // Thêm logic phát âm từ
              },
            ),
            IconButton(
              icon: Icon(Icons.star_border, color: AppColors.getColor(themeIndex, 'primaryText')),
              onPressed: () {
                // Thêm logic đánh dấu từ yêu thích
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(int themeIndex) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      width: double.infinity,
      color: AppColors.getColor(themeIndex, 'footerBackground'),
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity, // Set width to fill parent
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.getColor(themeIndex, 'messageUserBackground'),
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Study this set',
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 25,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
