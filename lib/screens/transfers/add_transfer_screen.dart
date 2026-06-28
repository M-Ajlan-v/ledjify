import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/data/account_data.dart';
import 'package:ledjify/models/account_model.dart';
import 'package:ledjify/screens/widgets/app_button.dart';
import 'package:ledjify/screens/widgets/app_text_field.dart';
import 'package:ledjify/screens/widgets/selection_tile.dart';

class AddTransferScreen extends StatefulWidget {
  const AddTransferScreen({super.key});

  @override
  State<AddTransferScreen> createState() => _AddTransferScreenState();
}

class _AddTransferScreenState extends State<AddTransferScreen> {
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  AccountModel? fromAccount;
  AccountModel? toAccount;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectFromAccount() async {
    final account = await showModalBottomSheet<AccountModel>(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: accounts.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = accounts[index];

              return ListTile(
                title: Text(item.name),
                subtitle: Text(
                  'Balance ₹${item.currentBalance.toStringAsFixed(0)}',
                ),
                onTap: () {
                  Navigator.pop(context, item);
                },
              );
            },
          ),
        );
      },
    );

    if (account != null) {
      setState(() {
        fromAccount = account;
      });
    }
  }

  Future<void> _selectToAccount() async {
    final account = await showModalBottomSheet<AccountModel>(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: accounts.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = accounts[index];

              return ListTile(
                title: Text(item.name),
                subtitle: Text(
                  'Balance ₹${item.currentBalance.toStringAsFixed(0)}',
                ),
                onTap: () {
                  Navigator.pop(context, item);
                },
              );
            },
          ),
        );
      },
    );

    if (account != null) {
      setState(() {
        toAccount = account;
      });
    }
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void _saveTransfer() {
    if (amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter amount'),
        ),
      );
      return;
    }

    if (fromAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select from account'),
        ),
      );
      return;
    }

    if (toAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select to account'),
        ),
      );
      return;
    }

    if (fromAccount!.id == toAccount!.id) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'From and To account cannot be same',
          ),
        ),
      );
      return;
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Add Transfer',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(
              label: 'Amount',
              hintText: 'Enter amount',
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            SelectionTile(
              title: 'From Account',
              value: fromAccount?.name ?? 'Select Account',
              icon: Icons.arrow_upward_rounded,
              onTap: _selectFromAccount,
            ),
            const SizedBox(height: 12),
            SelectionTile(
              title: 'To Account',
              value: toAccount?.name ?? 'Select Account',
              icon: Icons.arrow_downward_rounded,
              onTap: _selectToAccount,
            ),
            const SizedBox(height: 12),
            SelectionTile(
              title: 'Date',
              value: DateFormat(
                'dd MMM yyyy',
              ).format(selectedDate),
              icon: Icons.calendar_today_outlined,
              onTap: _selectDate,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Note',
              hintText: 'Transfer details',
              controller: noteController,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Save Transfer',
              icon: Icons.swap_horiz,
              color: AppColors.primary,
              onPressed: _saveTransfer,
            ),
          ],
        ),
      ),
    );
  }
}