// lib/src/presentation/pages/create_essay_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';
import 'package:englishapp/src/presentation/pages/gradle_writing_exam_page.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class CreateEssayPage extends StatefulWidget {
  @override
  _CreateEssayPageState createState() => _CreateEssayPageState();
}

class _CreateEssayPageState extends State<CreateEssayPage> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _scanImageToText(TextEditingController controller) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognizedText = await textDetector.processImage(inputImage);

    setState(() {
      controller.text = recognizedText.text;
    });

    textDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        backgroundColor: AppColors.getColor(themeIndex, 'headerBackground'),
        title: Text(
          'Tạo Đề Bài và Bài Làm',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInputSection(
                themeIndex,
                'Nhập Đề Bài',
                _topicController,
                'Scan Image to Text',
                    () => _scanImageToText(_topicController),
              ),
              const SizedBox(height: 16),
              _buildTextInputSection(
                themeIndex,
                'Nhập Bài Làm',
                _contentController,
                'Scan Image to Text',
                    () => _scanImageToText(_contentController),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GradeWritingExam(
                        topic: _topicController.text,
                        content: _contentController.text.replaceAll("(_)", "___"),
                      ),
                    ),
                  );
                },
                child: Text(
                  'Hoàn Thành',
                  style: TextStyle(
                    color: AppColors.getColor(themeIndex, 'primaryTextBlack'),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.getColor(themeIndex, 'buttonFinish'),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInputSection(
      int themeIndex,
      String labelText,
      TextEditingController controller,
      String scanButtonText,
      VoidCallback onScanPressed,
      ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập nội dung tại đây...',
              hintStyle: TextStyle(
                color: AppColors.getColor(themeIndex, 'secondaryText'),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onScanPressed,
              child: Text(
                scanButtonText,
                style: TextStyle(
                  color: AppColors.getColor(themeIndex, 'primaryTextBlack'),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
