import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/screens/widgets/app_button.dart';

class ImportDataScreen extends StatelessWidget {
  const ImportDataScreen({super.key});

  final List<Map<String, dynamic>> steps = const [
    {
      'number': 1,
      'title': 'Download Sample CSV',
      'description': 'Download the sample CSV file to understand the required format for your data.',
      'icon': Icons.download_outlined,
    },
    {
      'number': 2,
      'title': 'Fill Your Data',
      'description': 'Open the CSV file in Excel or any spreadsheet app. Add your contacts and transaction details in the same format.',
      'icon': Icons.edit_outlined,
    },
    {
      'number': 3,
      'title': 'Save the File',
      'description': 'Save the file after adding your data. Make sure to keep the CSV format.',
      'icon': Icons.save_outlined,
    },
    {
      'number': 4,
      'title': 'Upload File',
      'description': 'Tap the "Import File" button below and select the CSV file from your device storage.',
      'icon': Icons.upload_file_outlined,
    },
    {
      'number': 5,
      'title': 'Review & Confirm',
      'description': 'Review your imported data and confirm to save all contacts and transactions.',
      'icon': Icons.checklist_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Import Data',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary1, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: AppColors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Import Your Data',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Download the sample CSV file, fill your data, and upload it back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'How to Import',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Download sample CSV
                  },
                  icon: Icon(
                    Icons.download_rounded,
                    color: AppColors.primary1,
                    size: 18,
                  ),
                  label: Text(
                    'Sample CSV',
                    style: TextStyle(
                      color: AppColors.primary1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primary1.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...steps.map((step) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildStepCard(
                number: step['number'],
                title: step['title'],
                description: step['description'],
                icon: step['icon'],
              ),
            )).toList(),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.give.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.give.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.give,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your CSV must include: Name, Phone, Amount, Transaction Types',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            AppButton(text: 'import file', color: AppColors.primary, onPressed: (){Navigator.pop(context);}),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Skip for now',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard({
    required int number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.background),
        boxShadow: [
          BoxShadow(
            color: AppColors.background,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary1,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: AppColors.primary1,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}