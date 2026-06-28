import 'package:flutter/material.dart';
import 'package:ledjify/models/menu_item_model.dart';
import 'package:ledjify/screens/accounts/account_screen.dart';
import 'package:ledjify/screens/main_screen.dart';
import 'package:ledjify/screens/more/widgets/profile_card.dart';
import 'package:ledjify/screens/more/widgets/menu_section.dart';
import 'package:ledjify/screens/tools/import_data_screen.dart';
import 'package:ledjify/screens/transfers/transfer_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final manageItems = [
  MenuItemData(
  icon: Icons.wallet_outlined,
  color: Colors.green,
  title: 'Accounts',
  subtitle: 'Manage your accounts',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AccountScreen(),
      ),
    );
  },
),
  MenuItemData(
    icon: Icons.book_outlined,
    color: Colors.deepPurple,
    title: 'Cashbook',
    subtitle: 'Manage your cashbooks',
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const MainScreen(initialIndex: 2)
        ),
      );
    },
  ),
  MenuItemData(
    icon: Icons.receipt_long_outlined,
    color: Colors.green,
    title: 'Transactions',
    subtitle: 'View all transactions',
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const MainScreen(initialIndex: 3),
        ),
      );
    },
  ),
  MenuItemData(
    icon: Icons.swap_horiz_outlined,
    color: Colors.deepPurple,
    title: 'Transfer Money',
    subtitle: 'Transfer between accounts',
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TransferScreen(),
        ),
      );
    },
  ),
  MenuItemData(
    icon: Icons.people_outline,
    color: Colors.deepOrange,
    title: 'Contacts',
    subtitle: 'Manage people and balances',
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const MainScreen(initialIndex: 1),
        ),
      );
    },
  ),
];

    final toolItems = [
      MenuItemData(
        icon: Icons.bar_chart_outlined,
        color: Colors.blue,
        title: 'Reports',
        subtitle: 'Charts and analytics',
        onTap: () {
        },
      ),
      MenuItemData(
        icon: Icons.file_download_outlined,
        color: Colors.green,
        title: 'Export Data',
        subtitle: 'Export to Excel/PDF',
        onTap: () {
        },
      ),
      MenuItemData(
        icon: Icons.file_upload_outlined,
        color: Colors.blue,
        title: 'Import Data',
        subtitle: 'Import from files',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ImportDataScreen(),
            ),
          );
        },
      ),
    ];

    final moreItems = [
      MenuItemData(
        icon: Icons.backup_outlined,
        color: Colors.blue,
        title: 'Backup & Restore',
        subtitle: 'Backup your data',
        onTap: () {
        },
      ),
      MenuItemData(
        icon: Icons.settings_outlined,
        color: Colors.deepPurple,
        title: 'Settings',
        subtitle: 'App preferences',
        onTap: () {
        },
      ),
      MenuItemData(
        icon: Icons.help_outline,
        color: Colors.orange,
        title: 'Help & Support',
        subtitle: 'FAQ and Contact us',
        onTap: () {
        },
      ),
      MenuItemData(
        icon: Icons.info_outline,
        color: Colors.teal,
        title: 'About',
        subtitle: 'App information',
        onTap: () {
        },
      ),
    ];

    return Container(
      color: const Color(0xFFF5F5F7),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(
              name: 'Ajlan',
              phone: '+91 98765 43210',
              imageUrl: '',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            MenuSection(
              title: 'Manage',
              items: manageItems,
            ),
            MenuSection(
              title: 'Tools',
              items: toolItems,
            ),
            MenuSection(
              title: 'More',
              items: moreItems,
            ),
          ],
        ),
      ),
    );
  }
}