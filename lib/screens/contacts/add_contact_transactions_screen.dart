import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/models/contact_model.dart';
import 'package:ledjify/models/transaction_form_type.dart';
import 'package:ledjify/screens/widgets/app_button.dart';
import 'package:ledjify/screens/widgets/app_text_field.dart';
import 'package:ledjify/screens/widgets/party_card.dart';
import 'package:ledjify/screens/widgets/selection_tile.dart';
import 'package:ledjify/screens/widgets/transaction_type_card.dart';

class AddPartiesTransactionScreen extends StatefulWidget {
  final ContactModel contact;
  final PartyTransactionType initialType;

  const AddPartiesTransactionScreen({
    super.key,
    required this.contact,
    required this.initialType,
  });

  @override
  State<AddPartiesTransactionScreen> createState() =>
      _AddPartiesTransactionScreenState();
}

class _AddPartiesTransactionScreenState
    extends State<AddPartiesTransactionScreen> {
  late PartyTransactionType selectedType;

  final amountController =
      TextEditingController();

  final noteController =
      TextEditingController();

  String selectedAccount = 'Cash';

  DateTime selectedDate =
      DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Add Transaction',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PartyCard(
              contact: widget.contact,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                TransactionTypeCard(
                  title: 'Give',
                  subtitle:
                      'I gave money',
                  icon: Icons.arrow_upward,
                  selected:
                      selectedType ==
                          PartyTransactionType
                              .give,
                  onTap: () {
                    setState(() {
                      selectedType =
                          PartyTransactionType
                              .give;
                    });
                  },
                ),
                const SizedBox(width: 12),
                TransactionTypeCard(
                  title: 'Get',
                  subtitle:
                      'I received money',
                  icon:
                      Icons.arrow_downward,
                  selected:
                      selectedType ==
                          PartyTransactionType
                              .get,
                  onTap: () {
                    setState(() {
                      selectedType =
                          PartyTransactionType
                              .get;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Amount',
              hintText: 'Enter amount',
              controller:
                  amountController,
              keyboardType:
                  TextInputType.number,
            ),
            const SizedBox(height: 16),
            SelectionTile(
              title: 'Account',
              value: selectedAccount,
              icon: Icons.account_balance_wallet,
              onTap: () {},
            ),
            const SizedBox(height: 12),
            SelectionTile(
              title: 'Date',
              value: DateFormat(
                'dd MMM yyyy',
              ).format(selectedDate),
              icon: Icons.calendar_today,
              onTap: () async {
                final date =
                    await showDatePicker(
                  context: context,
                  firstDate:
                      DateTime(2020),
                  lastDate:
                      DateTime(2100),
                  initialDate:
                      selectedDate,
                );

                if (date != null) {
                  setState(() {
                    selectedDate = date;
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Note',
              hintText:
                  'Enter note',
              controller:
                  noteController,
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            SelectionTile(
              title: 'Attachment',
              value:
                  'Add photo or file',
              icon: Icons.attach_file,
              onTap: () {},
            ),
            const SizedBox(height: 24),
            AppButton(
              text:
                  'Save Transaction',
              color:
                  AppColors.primary,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}