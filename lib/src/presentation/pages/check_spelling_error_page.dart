// lib/src/presentation/pages/check_spelling_error_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';
import 'package:englishapp/src/services/typo_service.dart';

class CheckSpellingErrorPage extends StatefulWidget {
  @override
  _CheckSpellingErrorPageState createState() => _CheckSpellingErrorPageState();
}

class _CheckSpellingErrorPageState extends State<CheckSpellingErrorPage> {
  final ImagePicker _picker = ImagePicker();
  final TypoService typoService = TypoService(baseUrl: 'http://35.184.119.129:8550');
  final TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File? croppedFile = await _cropImage(pickedFile.path);
      if (croppedFile != null) {
        Map<String, dynamic> imageMessage = {
          'message': 'Image selected: ${croppedFile.path}',
          'isUser': true,
          'time': _getCurrentTime(),
          'image': croppedFile.path
        };
        setState(() {
          messages.add(imageMessage);
        });
      }
    }
  }

  Future<File?> _cropImage(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          minimumAspectRatio: 1.0,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }
  }

  Future<void> _fixTypos(BuildContext context, String id, String submission) async {
    try {
      final result = await typoService.fixTypos(id, submission);
      setState(() {
        messages.add({'message': result, 'isUser': false, 'time': _getCurrentTime()});
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageAndFooterBackgroundCenterChatbot'),
      body: Column(
        children: [
          CheckSpellingErrorHeader(
            themeIndex: themeIndex,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final showTime = index == 0 || messages[index]['time'] != messages[index - 1]['time'];
                return Column(
                  crossAxisAlignment: message['isUser'] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    if (showTime) _buildTimeText(message['time'], themeIndex),
                    if (message.containsKey('image') && message['image'] != null)
                      _buildImageBubble(message['image'], message['isUser'] ? Alignment.centerRight : Alignment.centerLeft),
                    if (!message.containsKey('image') || message['image'] == null)
                      _buildMessageBubble(
                        context,
                        message['message'],
                        message['isUser']
                            ? AppColors.getColor(themeIndex, 'messageUserBackground')
                            : AppColors.getColor(themeIndex, 'messageBotBackground'),
                        message['isUser'] ? Colors.black : Colors.black,
                        message['isUser'] ? Alignment.centerRight : Alignment.centerLeft,
                        themeIndex,
                      ),
                  ],
                );
              },
            ),
          ),
          CheckSpellingErrorFooter(
            themeIndex: themeIndex,
            textController: _textController,
            onMicroPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Micro pressed')),
              );
            },
            onCameraPressed: () async {
              await _requestPermission(Permission.camera);
              await _pickImage(context, ImageSource.camera);
            },
            onGalleryPressed: () async {
              await _requestPermission(Permission.photos);
              await _pickImage(context, ImageSource.gallery);
            },
            onSendPressed: () async {
              if (_textController.text.isNotEmpty) {
                final userMessage = _textController.text;
                final currentTime = _getCurrentTime();
                setState(() {
                  messages.add({'message': userMessage, 'isUser': true, 'time': currentTime});
                  _textController.clear();
                });
                await _fixTypos(context, 'unique_id', userMessage);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeText(String time, int themeIndex) {
    return Center(
      child: Text(
        time,
        style: TextStyle(
          color: AppColors.getColor(themeIndex, 'primaryText'),
          fontSize: 14, // Increase font size
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, String message, Color backgroundColor, Color textColor, Alignment alignment, int themeIndex) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 8),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: alignment == Alignment.centerLeft
              ? Border.all(width: 1, color: Colors.black.withOpacity(0.25))
              : null,
        ),
        child: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 14,  // Increase font size
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildImageBubble(String imagePath, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            File(imagePath),
          ),
        ),
      ),
    );
  }
}

class CheckSpellingErrorHeader extends StatelessWidget {
  final int themeIndex;

  const CheckSpellingErrorHeader({Key? key, required this.themeIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 100,
      color: AppColors.getColor(themeIndex, 'headerBackground'),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Text(
              'Logo App',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'CHECK SPELLING ERROR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class CheckSpellingErrorFooter extends StatelessWidget {
  final int themeIndex;
  final TextEditingController textController;
  final VoidCallback onMicroPressed;
  final VoidCallback onCameraPressed;
  final VoidCallback onGalleryPressed;
  final VoidCallback onSendPressed;

  const CheckSpellingErrorFooter({
    Key? key,
    required this.themeIndex,
    required this.textController,
    required this.onMicroPressed,
    required this.onCameraPressed,
    required this.onGalleryPressed,
    required this.onSendPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.getColor(themeIndex, 'pageAndFooterBackgroundCenterChatbot'),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.mic),
            color: AppColors.getColor(themeIndex, 'iconChatbotPrimary'),
            onPressed: onMicroPressed,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            color: AppColors.getColor(themeIndex, 'iconChatbotPrimary'),
            onPressed: onCameraPressed,
          ),
          IconButton(
            icon: Icon(Icons.photo),
            color: AppColors.getColor(themeIndex, 'iconChatbotPrimary'),
            onPressed: onGalleryPressed,
          ),
          PopupMenuButton<String>(
            icon: Container(
              width: 40,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1.5,
                  color: AppColors.getColor(themeIndex, 'iconChatbotPrimary'),
                ),
              ),
              child: Center(
                child: Text(
                  'VNI',
                  style: TextStyle(
                    color: AppColors.getColor(themeIndex, 'iconChatbotPrimary'),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            onSelected: (String result) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: $result')),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'ENG',
                child: Text('English - ENG'),
              ),
              const PopupMenuItem<String>(
                value: 'CHN',
                child: Text('Chinese - CHN'),
              ),
              const PopupMenuItem<String>(
                value: 'VNI',
                child: Text('Vietnamese - VNI'),
              ),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange, width: 2),
                    ),
                    child: Center(
                      child: IconButton(
                        padding: EdgeInsets.only(left: 0, bottom: 0),
                        icon: Icon(Icons.add, color: Colors.orange, size: 30),
                        onPressed: () {
                          // Add your desired functionality here
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.orange),
            onPressed: onSendPressed,
          ),
        ],
      ),
    );
  }
}
