import 'package:englishapp/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/presentation/pages/home2_page.dart';
import 'package:englishapp/src/presentation/pages/chatbot_page.dart';
import 'package:englishapp/src/presentation/pages/exam_page.dart';
import 'package:englishapp/src/presentation/pages/practice_page.dart';
import 'package:englishapp/src/presentation/pages/profile_page.dart';
import 'package:englishapp/src/utils/app_localizations.dart';
import 'package:englishapp/res/assets/icons/flutter-icons-8db9be19/my_flutter_app_icons.dart';
import 'package:englishapp/src/theme/theme_provider.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Home2(),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomNavigationBarItems(AppLocalizations.of(context), themeIndex),
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.getColor(themeIndex, 'primaryText'),
        unselectedItemColor: AppColors.getColor(themeIndex, 'secondaryText'),
        backgroundColor: AppColors.getColor(themeIndex, 'navigationBarBackground'),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(AppLocalizations? localizations, int themeIndex) {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: AppColors.getColor(themeIndex, 'primaryText')),
        label: localizations?.translate('home') ?? 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(MyFlutterApp.book_open, color: AppColors.getColor(themeIndex, 'primaryText')),
        label: localizations?.translate('practice') ?? 'Practice',
      ),
      BottomNavigationBarItem(
        icon: Icon(MyFlutterApp.camera, color: AppColors.getColor(themeIndex, 'primaryText')),
        label: localizations?.translate('exam') ?? 'Exam',
      ),
      BottomNavigationBarItem(
        icon: Icon(MyFlutterApp.facebook_messenger, color: AppColors.getColor(themeIndex, 'primaryText')),
        label: localizations?.translate('chatbot') ?? 'Chatbot',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person, color: AppColors.getColor(themeIndex, 'primaryText')),
        label: localizations?.translate('profile') ?? 'Profile',
      ),
    ];
  }
}
