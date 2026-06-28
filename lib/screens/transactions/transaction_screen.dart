import 'package:flutter/material.dart';
import 'package:ledjify/screens/transactions/widgets/periodic_selector.dart';
import 'package:provider/provider.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/helpers/transaction_helpers.dart';
import 'package:ledjify/screens/widgets/transaction_list.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TransactionHelper>().loadTransactions();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'All transactions',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<TransactionHelper>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Text(
                'Error: ${provider.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: provider.search,
                        decoration: InputDecoration(
                          hintText: 'Search transactions',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    provider.search('');
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {
                          provider.openFilters(context);
                        },
                        color: provider.typeFilter != 'ALL' 
                            ? AppColors.primary 
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Transactions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    PeriodSelector(
                      currentPeriod: provider.periodLabel,
                      onTap: () {
                        provider.openPeriodSelector(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (provider.transactions.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text('No transactions found'),
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: TransactionList(
                      transactions: provider.transactions,
                      titleBuilder: provider.getTitle,
                      cashInBuilder: provider.getCashIn,
                      cashOutBuilder: provider.getCashOut,
                      typeBuilder: provider.getType,
                      accountNameBuilder: provider.getAccountName,
                      accountPrefixBuilder: provider.getAccountPrefix,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}