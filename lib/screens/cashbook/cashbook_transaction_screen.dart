import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/data/account_data.dart';
import 'package:ledjify/data/utility_data.dart';
import 'package:ledjify/models/account_model.dart';
import 'package:ledjify/models/cashbook_transaction_type.dart';
import 'package:ledjify/models/utility_model.dart';
import 'package:ledjify/screens/widgets/app_button.dart';
import 'package:ledjify/screens/widgets/app_text_field.dart';
import 'package:ledjify/screens/widgets/selection_tile.dart';
import 'package:ledjify/screens/widgets/transaction_type_card.dart';

class CashbookTransactionScreen extends StatefulWidget {
  final CashbookTransactionType initialType;

  const CashbookTransactionScreen({
    super.key,
    required this.initialType,
  });

  @override
  State<CashbookTransactionScreen> createState() =>
      _CashbookTransactionScreenState();
}

class _CashbookTransactionScreenState
    extends State<CashbookTransactionScreen> {
  late CashbookTransactionType selectedType;

  final amountController = TextEditingController();
  final noteController = TextEditingController();

  AccountModel? selectedAccount;
  UtilityModel? selectedUtility;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialType;
  }
  List<UtilityModel> get filteredUtilities {
  final type =
      selectedType == CashbookTransactionType.income
          ? 'INCOME'
          : 'EXPENSE';

  return UtilityData.utilities
      .where((u) => u.type == type)
      .toList();
}

  Future<void> _selectAccount() async {
    final account = await showModalBottomSheet<AccountModel>(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final item = accounts[index];

              return ListTile(
                title: Text(item.name),
                subtitle: Text(
                  '₹ ${item.currentBalance.toStringAsFixed(0)}',
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
        selectedAccount = account;
      });
    }
  }

  Future<void> _selectUtility() async {
    final utility = await showModalBottomSheet<UtilityModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        final searchController = TextEditingController();

        List<UtilityModel> filtered = UtilityData.utilities
            .where(
              (u) =>
                  u.type ==
                  (selectedType ==
                          CashbookTransactionType.income
                      ? 'INCOME'
                      : 'EXPENSE'),
            )
            .toList();

        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 500,
                  child: Column(
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search or create reason',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            filtered = UtilityData.utilities
                                .where(
                                  (u) =>
                                      u.type ==
                                          (selectedType ==
                                                  CashbookTransactionType
                                                      .income
                                              ? 'INCOME'
                                              : 'EXPENSE') &&
                                      u.categoryName
                                          .toLowerCase()
                                          .contains(
                                            value.toLowerCase(),
                                          ),
                                )
                                .toList();
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              filtered.length + 1,
                          itemBuilder:
                              (context, index) {
                            if (index ==
                                filtered.length) {
                              return ListTile(
                                leading:
                                    const Icon(Icons.add),
                                title: Text(
                                  'Create "${searchController.text}"',
                                ),
                                onTap: () {
                                  if (searchController
                                      .text
                                      .trim()
                                      .isEmpty) {
                                    return;
                                  }

                                  Navigator.pop(
                                    context,
                                    UtilityModel(
                                      id: 0,
                                      userId: 1,
                                      categoryName:
                                          searchController.text
                                              .trim(),
                                      type: selectedType ==
                                              CashbookTransactionType
                                                  .income
                                          ? 'INCOME'
                                          : 'EXPENSE',
                                    ),
                                  );
                                },
                              );
                            }

                            final item =
                                filtered[index];

                            return ListTile(
                              title: Text(
                                item.categoryName,
                              ),
                              onTap: () {
                                Navigator.pop(
                                  context,
                                  item,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    if (utility != null) {
      setState(() {
        selectedUtility = utility;
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

  void _saveTransaction() {
    if (amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter amount'),
        ),
      );
      return;
    }

    if (selectedUtility == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select reason'),
        ),
      );
      return;
    }

    if (selectedAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select account'),
        ),
      );
      return;
    }
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
          'Add Transaction',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                TransactionTypeCard(
                  title: 'Income',
                  subtitle: 'Money received',
                  icon: Icons.arrow_downward,
                  selected:
                      selectedType ==
                          CashbookTransactionType
                              .income,
                  onTap: () {
                    setState(() {
                      selectedType =
                          CashbookTransactionType
                              .income;
                      selectedUtility = null;
                    });
                  },
                ),
                const SizedBox(width: 12),
                TransactionTypeCard(
                  title: 'Expense',
                  subtitle: 'Money spent',
                  icon: Icons.arrow_upward,
                  selected:
                      selectedType ==
                          CashbookTransactionType
                              .expense,
                  onTap: () {
                    setState(() {
                      selectedType =
                          CashbookTransactionType
                              .expense;
                      selectedUtility = null;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Amount',
              hintText: 'Enter amount',
              controller: amountController,
              keyboardType:
                  TextInputType.number,
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reason',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 10),
                Autocomplete<UtilityModel>(
                  displayStringForOption: (option) =>
                      option.categoryName,
                  optionsBuilder: (textEditingValue) {
                    final utilities = UtilityData.utilities.where(
                      (u) =>
                          u.type ==
                          (selectedType ==
                                  CashbookTransactionType.income
                              ? 'INCOME'
                              : 'EXPENSE'),
                    );

                    if (textEditingValue.text.isEmpty) {
                      return utilities;
                    }

                    return utilities.where(
                      (u) => u.categoryName
                          .toLowerCase()
                          .contains(
                            textEditingValue.text.toLowerCase(),
                          ),
                    );
                  },
                  onSelected: (utility) {
                    setState(() {
                      selectedUtility = utility;
                    });
                  },
                  fieldViewBuilder: (
                    context,
                    controller,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    controller.text =
                        selectedUtility?.categoryName ?? '';

                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        hintText: 'Search reason',
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    );
                  },
                  optionsViewBuilder: (
                    context,
                    onSelected,
                    options,
                  ) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4,
                        borderRadius:
                            BorderRadius.circular(12),
                        child: SizedBox(
                          width: MediaQuery.of(context)
                              .size
                              .width -
                              32,
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            children: options.map((option) {
                              return ListTile(
                                title: Text(
                                  option.categoryName,
                                ),
                                onTap: () {
                                  onSelected(option);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            SelectionTile(
              title: 'Account',
              value:
                  selectedAccount?.name ??
                      'Select Account',
              icon: Icons
                  .account_balance_wallet_outlined,
              onTap: _selectAccount,
            ),
            const SizedBox(height: 12),
            SelectionTile(
              title: 'Date',
              value: DateFormat(
                'dd MMM yyyy',
              ).format(selectedDate),
              icon:
                  Icons.calendar_today_outlined,
              onTap: _selectDate,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Note',
              hintText: 'Enter note',
              controller: noteController,
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            SelectionTile(
              title: 'Attachment',
              value: 'Add photo or file',
              icon: Icons.attach_file,
              onTap: () {},
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Save Transaction',
              color: AppColors.primary,
              onPressed: _saveTransaction,
            ),
          ],
        ),
      ),
    );
  }
}