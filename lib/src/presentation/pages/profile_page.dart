import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/utils/app_localizations.dart';
import 'package:englishapp/src/theme/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildProfileSectionTitle(AppLocalizations.of(context)!.translate('account_settings')),
            const SizedBox(height: 10),
            _buildProfileOption(
              icon: Icons.account_circle,
              title: AppLocalizations.of(context)!.translate('edit_profile'),
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.lock,
              title: AppLocalizations.of(context)!.translate('change_password'),
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.notifications,
              title: AppLocalizations.of(context)!.translate('notification_settings'),
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _buildProfileSectionTitle(AppLocalizations.of(context)!.translate('support')),
            const SizedBox(height: 10),
            _buildProfileOption(
              icon: Icons.help,
              title: AppLocalizations.of(context)!.translate('help_center'),
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.feedback,
              title: AppLocalizations.of(context)!.translate('feedback'),
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _buildProfileSectionTitle(AppLocalizations.of(context)!.translate('about')),
            const SizedBox(height: 10),
            _buildProfileOption(
              icon: Icons.info,
              title: AppLocalizations.of(context)!.translate('terms_of_service'),
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.privacy_tip,
              title: AppLocalizations.of(context)!.translate('privacy_policy'),
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _buildThemeOption(context, themeProvider),
            const SizedBox(height: 20),
            _buildLanguageOption(context, themeProvider),
            const SizedBox(height: 20),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/res/assets/avatar.jpg')
          ),
          const SizedBox(height: 10),
          Text(
            'Truong',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'truong@gmail.com',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }

  Widget _buildProfileOption({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildThemeOption(BuildContext context, ThemeProvider themeProvider) {
    return ListTile(
      leading: Icon(Icons.color_lens, color: Colors.blueAccent),
      title: Text(AppLocalizations.of(context)!.translate('theme')),
      trailing: DropdownButton<int>(
        value: themeProvider.themeIndex,
        onChanged: (int? newThemeIndex) {
          if (newThemeIndex != null) {
            themeProvider.setTheme(newThemeIndex);
          }
        },
        items: [
          DropdownMenuItem(
            value: 0,
            child: Text('Purple Theme'),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('Pink Theme'),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text('Yellow Theme'),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, ThemeProvider themeProvider) {
    return ListTile(
      leading: Icon(Icons.language, color: Colors.blueAccent),
      title: Text(AppLocalizations.of(context)!.translate('language')),
      trailing: DropdownButton<Locale>(
        value: themeProvider.locale,
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            themeProvider.setLocale(newLocale);
          }
        },
        items: AppLocalizations.supportedLocales.map<DropdownMenuItem<Locale>>((Locale locale) {
          return DropdownMenuItem<Locale>(
            value: locale,
            child: Text(locale.languageCode == 'en' ? 'English' : 'Tiếng Việt'),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Handle logout
        },
        child: Text(AppLocalizations.of(context)!.translate('logout')),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          textStyle: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
