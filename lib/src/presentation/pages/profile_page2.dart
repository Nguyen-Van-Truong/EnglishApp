import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';
import 'package:englishapp/src/utils/app_localizations.dart';

class ProfilePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(themeIndex),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('CURRENT SUBSCRIPTION', themeIndex),
                  const SizedBox(height: 8),
                  _buildSubscriptionInfo(themeIndex),
                  const SizedBox(height: 16),
                  _buildNotificationCard(themeIndex),
                  const SizedBox(height: 16),
                  _buildSectionTitle('OVERVIEW', themeIndex),
                  const SizedBox(height: 8),
                  _buildOverview(themeIndex),
                  const SizedBox(height: 16),
                  _buildThemeOption(context, themeProvider, themeIndex), // Thêm dòng này
                  const SizedBox(height: 16),
                  _buildLanguageOption(context, themeProvider, themeIndex), // Thêm dòng này
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(int themeIndex) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'headerBackgroundProfile'),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.getColor(themeIndex, 'headerCircle3'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Avatar',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'USERNAME',
                      style: TextStyle(
                        color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
                        fontSize: 23,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'username',
                            style: TextStyle(
                              color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•',
                          style: TextStyle(color: AppColors.getColor(themeIndex, 'primaryTextHeader')),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Joined in June 2024',
                            style: TextStyle(
                              color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildProfileStat('0', 'Following', themeIndex),
                        const SizedBox(width: 16),
                        _buildProfileStat('0', 'Followers', themeIndex),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.getColor(themeIndex, 'headerBackgroundProfile'),
                            side: BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'EDIT PROFILE',
                            style: TextStyle(
                              color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8), // Khoảng cách nhỏ giữa button và icon
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white), // Border màu trắng
                            borderRadius: BorderRadius.circular(4), // Bo tròn góc nếu cần
                          ),
                          child: Icon(
                            Icons.ios_share_outlined,
                            color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String count, String label, int themeIndex) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
            fontSize: 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, int themeIndex) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.getColor(themeIndex, 'primaryText'),
        fontSize: 20,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildSubscriptionInfo(int themeIndex) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name of subscription',
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Expires on June 26, 2024',
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverview(int themeIndex) {
    return Column(
      children: [
        Row(
          children: [
            _buildOverviewCard('3', 'Streak day', 'lib/res/assets/icon_app/icStreak.png', themeIndex),
            const SizedBox(width: 16),
            _buildOverviewCard('974', 'Starpoint', 'lib/res/assets/icon_app/icStar.png', themeIndex),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildOverviewCard('8', 'Completed exercise', 'lib/res/assets/icon_app/icCompleted.png', themeIndex),
            const SizedBox(width: 16),
            _buildOverviewCard('862', 'Practice in minutes', 'lib/res/assets/icon_app/icPractice.png', themeIndex),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String count, String label, String iconPath, int themeIndex) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(iconPath, width: 24, height: 24), // Sử dụng hình ảnh tùy chỉnh
                const SizedBox(width: 8),
                Text(
                  count,
                  style: TextStyle(
                    color: AppColors.getColor(themeIndex, 'primaryText'),
                    fontSize: 30,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: AppColors.getColor(themeIndex, 'primaryText'),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(int themeIndex) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.getColor(themeIndex, 'continueSubscriptionBackground'),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your “Name of Subscription” will expire today.',
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.getColor(themeIndex, 'buttonContinueSubscription'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Center(
              child: Text(
                'CONTINUE YOUR SUBSCRIPTION',
                style: TextStyle(
                  color: AppColors.getColor(themeIndex, 'primaryText'),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, ThemeProvider themeProvider, int themeIndex) {
    return ListTile(
      leading: Icon(Icons.color_lens, color: Colors.blueAccent),
      title: Text('Change Theme', style: TextStyle(
        color: AppColors.getColor(themeIndex, 'primaryText'),
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      )),
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

  Widget _buildLanguageOption(BuildContext context, ThemeProvider themeProvider, int themeIndex) {
    return ListTile(
      leading: Icon(Icons.language, color: Colors.blueAccent),
      title: Text('Change Language', style: TextStyle(
        color: AppColors.getColor(themeIndex, 'primaryText'),
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      )),
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
}
