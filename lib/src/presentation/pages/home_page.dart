import 'package:englishapp/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:englishapp/src/presentation/pages/chatbot_page.dart';
import 'package:englishapp/src/presentation/pages/exam_page.dart';
import 'package:englishapp/src/presentation/pages/learn_page.dart';
import 'package:englishapp/src/presentation/pages/practice_page.dart';
import 'package:englishapp/src/presentation/pages/profile_page.dart';
import 'package:englishapp/src/utils/app_localizations.dart';
import 'package:englishapp/res/assets/icons/flutter-icons-8db9be19/my_flutter_app_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    LearnPage(),
    PracticePage(),
    ExamPage(),
    ChatbotPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomNavigationBarItems(localizations),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.navigationBarBackground, // Sử dụng màu nền từ AppColors
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensure the items are fixed and not shifting
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(AppLocalizations? localizations) {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.book),
        label: localizations?.translate('learn') ?? 'Learn',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.edit),
        label: localizations?.translate('practice') ?? 'Practice',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.check_box),
        label: localizations?.translate('exam') ?? 'Exam',
      ),
      BottomNavigationBarItem(
        icon: const Icon(MyFlutterApp.hand_sparkles),
        label: localizations?.translate('chatbot') ?? 'Chatbot',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: localizations?.translate('profile') ?? 'Profile',
      ),
    ];
  }
}
