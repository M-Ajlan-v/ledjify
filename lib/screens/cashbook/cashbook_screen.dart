import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/helpers/cashbook_helpers.dart';
import 'package:ledjify/screens/cashbook/widgets/cashbook_search_bar.dart';
import 'package:ledjify/screens/cashbook/widgets/cashbook_summary_card.dart';
import 'package:ledjify/screens/widgets/app_button.dart';
import 'package:ledjify/screens/widgets/transaction_list.dart';
import 'package:ledjify/models/cashbook_transaction_type.dart';
import 'package:ledjify/screens/cashbook/cashbook_transaction_screen.dart';

class CashbookScreen extends StatefulWidget {
  const CashbookScreen({super.key});

  @override
  State<CashbookScreen> createState() => _CashbookScreenState();
}

class _CashbookScreenState extends State<CashbookScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CashbookHelper>().loadTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CashbookHelper>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Cashbook',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CashbookSearchBar(
                    onChanged: provider.search,
                    onFilterTap: () => provider.openFilters(context),
                  ),
                  CashbookSummaryCard(
                    period: provider.periodLabel,
                    income: provider.incomeTotal,
                    expense: provider.expenseTotal,
                    onPeriodTap: () => provider.openPeriodSelector(context),
                  ),
                  TransactionList(
                    transactions: provider.filteredTransactions,
                    titleBuilder: provider.getTitle,
                    cashInBuilder: provider.getCashIn,
                    cashOutBuilder: provider.getCashOut,
                    typeBuilder: provider.getType,
                    accountNameBuilder: provider.getAccountName,
                    accountPrefixBuilder: provider.getAccountPrefix,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'INCOME',
                    icon: Icons.arrow_upward,
                    color: AppColors.give,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CashbookTransactionScreen(
                            initialType:
                                CashbookTransactionType.income,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: 'EXPENSE',
                    icon: Icons.arrow_downward,
                    color: AppColors.get,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CashbookTransactionScreen(
                            initialType:
                                CashbookTransactionType.expense,
                          ),
                        ),
                      );
                    },
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