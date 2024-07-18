// lib/src/presentation/pages/chatbot_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';

class ChatbotPage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image selected: ${pickedFile.path}')),
      );
    }
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }
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
            child: ChatMessagesList(themeIndex: themeIndex),
          ),
          ChatbotFooter(
            themeIndex: themeIndex,
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
          ),
        ],
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
          Text(
            'CHAT TITLE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessagesList extends StatelessWidget {
  final int themeIndex;

  const ChatMessagesList({Key? key, required this.themeIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildTimeText('17:00', themeIndex),
        _buildMessageBubble(
            context,
            'Give me an example of brain drain',
            AppColors.getColor(themeIndex, 'messageUserBackground'),
            Colors.black,
            Alignment.centerRight,
            themeIndex),
        _buildMessageBubble(
            context,
            'There are different examples of the brain in real-life situations. One example is qualified people from developing nations being enticed by greater wages and better working conditions in nations from Western Europe, such as the U.S. They migrate from their countries to opt for such situations in the long run.',
            AppColors.getColor(themeIndex, 'messageBotBackground'),
            Colors.black,
            Alignment.centerLeft,
            themeIndex),
        _buildTimeText('19:58', themeIndex),
        _buildMessageBubble(
            context,
            'Other user’s question',
            AppColors.getColor(themeIndex, 'messageUserBackground'),
            Colors.black,
            Alignment.centerRight,
            themeIndex),
        _buildMessageBubble(
            context,
            'Chatbot reply',
            AppColors.getColor(themeIndex, 'messageBotBackground'),
            Colors.black,
            Alignment.centerLeft,
            themeIndex),
      ],
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
}

class ChatbotFooter extends StatefulWidget {
  final int themeIndex;
  final VoidCallback onMicroPressed;
  final VoidCallback onCameraPressed;
  final VoidCallback onGalleryPressed;

  const ChatbotFooter({
    Key? key,
    required this.themeIndex,
    required this.onMicroPressed,
    required this.onCameraPressed,
    required this.onGalleryPressed,
  }) : super(key: key);

  @override
  _ChatbotFooterState createState() => _ChatbotFooterState();
}

class _ChatbotFooterState extends State<ChatbotFooter> {
  String languageIconText = 'VNI';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.getColor(widget.themeIndex, 'footerBackground'),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.mic),
            color: Colors.white,
            onPressed: widget.onMicroPressed,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            color: Colors.white,
            onPressed: widget.onCameraPressed,
          ),
          IconButton(
            icon: Icon(Icons.photo),
            color: Colors.white,
            onPressed: widget.onGalleryPressed,
          ),
          PopupMenuButton<String>(
            icon: Container(
              width: 40,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1.5, color: Color(0xFFFFE6CA)),
              ),
              child: Center(
                child: Text(
                  languageIconText,
                  style: TextStyle(
                    color: Color(0xFFFFE6CA),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            onSelected: (String result) {
              setState(() {
                languageIconText = result;
              });
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
                value: 'Settings',
                child: Text('Settings'),
              ),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
