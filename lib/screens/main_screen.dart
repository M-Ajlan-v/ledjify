import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/screens/cashbook/cashbook_screen.dart';
import 'package:ledjify/screens/contacts/add_contact_screen.dart';
import 'package:ledjify/screens/home/home_screen.dart';
import 'package:ledjify/screens/contacts/contact_screen.dart';
import 'package:ledjify/screens/more/more_screen.dart';
import 'package:ledjify/screens/transactions/transaction_screen.dart';

class MainScreen extends StatefulWidget {
    final int initialIndex;

  const MainScreen({
    super.key,
    this.initialIndex=0,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int selectedIndex;

  @override
  void initState(){
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  final List<Widget> screens = const [
    HomeScreen(),
    ContactScreen(),
    CashbookScreen(),
    TransactionScreen(),
    MoreScreen(),
  ];

  void onNavTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const Drawer(),
      body: IndexedStack(index: selectedIndex, children: screens),
      floatingActionButton: selectedIndex == 1
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddContactScreen(),
                  ),
                );
              },
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.person_add),
              label: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Add Party',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
            )
          : null,
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                        selectedIndex == 0 ? Icons.home : Icons.home_outlined,
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
                        selectedIndex == 1 ? Icons.people : Icons.people_outline,
                        color: selectedIndex == 1
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Contacts',
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
              Expanded(
                child: InkWell(
                  onTap: () => onNavTap(2),
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        selectedIndex == 2
                            ? Icons.paid
                            : Icons.paid_outlined,
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
                            ? Icons.payments
                            : Icons.payments_outlined,
                        color: selectedIndex == 3
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Transactions',
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
              Expanded(
                child: InkWell(
                  onTap: () => onNavTap(4),
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        selectedIndex == 4
                            ? Icons.grid_view_rounded
                            : Icons.grid_view_outlined,
                        color: selectedIndex == 4
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'More',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: selectedIndex == 4
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
      ),
    );
  }
}