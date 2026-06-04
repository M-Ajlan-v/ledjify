import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/screens/cashbook/cashbook_screen.dart';
import 'package:ledjify/screens/home/home_screen.dart';
import 'package:ledjify/screens/parties/parties_screen.dart';
import 'package:ledjify/screens/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0; // variable

  final List<Widget> screens = const [
    HomeScreen(),
    PartiesScreen(),
    CashbookScreen(),
    ProfileScreen(),
  ];

  void onNavTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(),
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onNavTap(0),
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      selectedIndex == 0
                          ? Icons.home
                          : Icons.home_outlined,
                      color: selectedIndex == 0
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: selectedIndex == 0
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: () => onNavTap(1),
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      selectedIndex == 1
                          ? Icons.people
                          : Icons.people_outline,
                      color: selectedIndex == 1
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Parties',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: selectedIndex == 1
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Center Add Button
            GestureDetector(
              onTap: () {
                // TODO: Add action
              },
              child: Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: () => onNavTap(2),
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      selectedIndex == 2
                          ? Icons.account_balance_wallet
                          : Icons.account_balance_wallet_outlined,
                      color: selectedIndex == 2
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cashbook',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: selectedIndex == 2
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: () => onNavTap(3),
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      selectedIndex == 3
                          ? Icons.person
                          : Icons.person_outline,
                      color: selectedIndex == 3
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: selectedIndex == 3
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}