import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:englishapp/src/theme/theme_provider.dart';
import 'package:englishapp/src/theme/colors.dart';

class RoomSetupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeIndex = themeProvider.themeIndex;

    return Scaffold(
      backgroundColor: AppColors.getColor(themeIndex, 'pageBackground'),
      appBar: AppBar(
        backgroundColor: AppColors.getColor(themeIndex, 'headerBackground'),
        title: Text(
          'ROOM SETUP',
          style: TextStyle(
            color: AppColors.getColor(themeIndex, 'primaryTextHeader'),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField('NAME', themeIndex),
            const SizedBox(height: 16),
            _buildInputField('CHARACTER', themeIndex),
            const SizedBox(height: 16),
            _buildSelectionField('Gender', ['Male', 'Female'], themeIndex),
            const SizedBox(height: 16),
            _buildSelectionField('Job', [
              'Teacher',
              'Doctor',
              'Cashier',
              'Waiter',
              'Electrician',
              'Farmer',
            ], themeIndex),
            const SizedBox(height: 16),
            _buildLabel('Other feature', themeIndex),
            const SizedBox(height: 8),
            _buildFeatureSelection(themeIndex),
            const SizedBox(height: 32),
            _buildLabel('CONTEXT', themeIndex),
            const SizedBox(height: 8),
            _buildSelectionField('Context', [
              'Restaurant',
              'Office',
              'Hospital',
              'Dental care',
              'Farm',
            ], themeIndex),
            const SizedBox(height: 16),
            _buildMockTestSelection(themeIndex),
            const SizedBox(height: 32),
            Center(
              child: SizedBox(
                width: double.infinity, // Set width to fill parent
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.getColor(themeIndex, 'buttonCall'),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'CALL',
                    style: TextStyle(
                      color: AppColors.getColor(themeIndex, 'primaryText'),
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, int themeIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, themeIndex),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.getColor(themeIndex, 'secondaryText')),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String label, int themeIndex) {
    return Text(
      label,
      style: TextStyle(
        color: AppColors.getColor(themeIndex, 'primaryText'),
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildSelectionField(String label, List<String> options, int themeIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, themeIndex),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: options.map((option) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                option,
                style: TextStyle(
                  color: AppColors.getColor(themeIndex, 'primaryText'),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFeatureSelection(int themeIndex) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(6, (index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Feature',
            style: TextStyle(
              color: AppColors.getColor(themeIndex, 'primaryText'),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMockTestSelection(int themeIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'IELTS mocktest',
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.getColor(themeIndex, 'secondaryText').withOpacity(0.25)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'TOEIC mocktest',
                  style: TextStyle(
                    color: AppColors.getColor(themeIndex, 'primaryText'),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
