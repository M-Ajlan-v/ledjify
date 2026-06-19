import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/data/account_data.dart';
import 'package:ledjify/screens/accounts/widgets/account_card.dart';
import 'package:ledjify/screens/widgets/app_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalBalance = accounts.fold<double>(
      0,
      (sum, acc) => sum + acc.currentBalance,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Accounts',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight(800)
        ),
        ),
        backgroundColor: AppColors.background,
        leading: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                return AccountCard(account: accounts[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: AppButton(text: 'Add Account', color: AppColors.primary,
                icon: Icons.add,
                onPressed: (){}
            ),
          )
        ],
      ),
    );
  }
}
