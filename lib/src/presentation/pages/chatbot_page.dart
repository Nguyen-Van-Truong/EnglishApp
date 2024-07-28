// lib/src/presentation/pages/chatbot_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';
import 'package:englishapp/src/services/chatbot_service.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final ImagePicker _picker = ImagePicker();
  final ChatbotService chatbotService = ChatbotService(baseUrl: 'http://35.184.119.129:8580');
  final TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    chatbotService.listenToSSE(_handleSSEEvent);
  }

  @override
  void dispose() {
    chatbotService.dispose();
    super.dispose();
  }

  void _handleSSEEvent(String event) {
    setState(() {
      if (event == '[END_STREAM_SSE\n]' || event.trim() == '[END_STREAM_SSE]') {
        setState(() {
          chatbotService.dispose();
        });
        return;
      }

      if (messages.isEmpty || messages.last['isUser']) {
        messages.add({
          'message': '',
          'isUser': false,
          'time': _getCurrentTime()
        });
      }

      String currentEvent = event;

      // Nếu event bắt đầu bằng khoảng trắng, trim và thêm khoảng trắng vào cuối message hiện tại
      if (currentEvent.startsWith('  ')) {
        currentEvent = currentEvent.trim();
        messages.last['message'] += ' ' + currentEvent;
      } else {
        messages.last['message'] += currentEvent.trim();
      }
    });
    // print('Output:$event');
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File? croppedFile = await _cropImage(pickedFile.path);
      if (croppedFile != null) {
        setState(() {
          messages.add({
            'message': 'Image selected: ${croppedFile.path}',
            'isUser': true,
            'time': _getCurrentTime(),
            'image': croppedFile.path
          });
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

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      print('Permission granted');
    } else {
      print('Permission denied');
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
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      body: Column(
        children: [
          ChatbotHeader(themeIndex: themeIndex),
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
                    if (message.containsKey('image'))
                      _buildImageBubble(message['image'], message['isUser'] ? Alignment.centerRight : Alignment.centerLeft),
                    if (!message.containsKey('image'))
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
          ChatbotFooter(
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
                chatbotService.sendMessage(userMessage);
                print('Input: $userMessage');
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
          fontSize: 12,
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
            fontSize: 12,
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

class ChatbotHeader extends StatelessWidget {
  final int themeIndex;

  const ChatbotHeader({Key? key, required this.themeIndex}) : super(key: key);

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
              'CHATBOT',
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

class ChatbotFooter extends StatelessWidget {
  final int themeIndex;
  final TextEditingController textController;
  final VoidCallback onMicroPressed;
  final VoidCallback onCameraPressed;
  final VoidCallback onGalleryPressed;
  final VoidCallback onSendPressed;

  const ChatbotFooter({
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
      color: AppColors.getColor(themeIndex, 'footerBackground'),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.mic),
            color: Colors.white,
            onPressed: onMicroPressed,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            color: Colors.white,
            onPressed: onCameraPressed,
          ),
          IconButton(
            icon: Icon(Icons.photo),
            color: Colors.white,
            onPressed: onGalleryPressed,
          ),
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.white,
            onPressed: onSendPressed,
          ),
        ],
      ),
    );
  }
}
