import 'package:englishapp/main.dart';
import 'package:englishapp/src/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('profile')),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
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
            _buildLanguageOption(context),
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

  Widget _buildLanguageOption(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.language, color: Colors.blueAccent),
      title: Text(AppLocalizations.of(context)!.translate('language')),
      trailing: DropdownButton<Locale>(
        value: Localizations.localeOf(context),
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            _changeLanguage(context, newLocale);
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

  void _changeLanguage(BuildContext context, Locale locale) {
    MyApp.setLocale(context, locale);
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
