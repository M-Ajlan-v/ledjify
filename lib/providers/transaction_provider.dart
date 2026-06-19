// providers/transaction_provider.dart
import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/models/transaction_model.dart';
import 'package:ledjify/services/transaction_service.dart';
import 'package:ledjify/data/contact_data.dart';
import 'package:ledjify/data/utility_data.dart';
import 'package:ledjify/data/account_data.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionService _service = TransactionService();
  
  List<TransactionModel> _transactions = [];
  String _searchQuery = '';
  String _typeFilter = 'ALL';
  String _period = 'Today';
  DateTimeRange? _customRange;
  
  bool _isLoading = false;
  String? _error;

  List<TransactionModel> get transactions => _filteredTransactions;
  List<TransactionModel> get allTransactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get period => _period;
  String get typeFilter => _typeFilter;

  TransactionProvider() {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _transactions = await _service.getTransactions();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void filterByType(String type) {
    _typeFilter = type;
    notifyListeners();
  }

  Future<void> openFilters(BuildContext context) async {
  final result = await showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.background,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      String localType = _typeFilter;
      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Filter Transactions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            RadioListTile(
                              value: 'ALL',
                              groupValue: localType,
                              title: const Text('All Transactions'),
                              onChanged: (value) {
                                setState(() {
                                  localType = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              value: 'INCOME',
                              groupValue: localType,
                              title: const Text('Income'),
                              onChanged: (value) {
                                setState(() {
                                  localType = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              value: 'EXPENSE',
                              groupValue: localType,
                              title: const Text('Expense'),
                              onChanged: (value) {
                                setState(() {
                                  localType = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              value: 'GET',
                              groupValue: localType,
                              title: const Text('Get'),
                              onChanged: (value) {
                                setState(() {
                                  localType = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              value: 'GIVE',
                              groupValue: localType,
                              title: const Text('Give'),
                              onChanged: (value) {
                                setState(() {
                                  localType = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              value: 'TRANSFER',
                              groupValue: localType,
                              title: const Text('Transfer'),
                              onChanged: (value) {
                                setState(() {
                                  localType = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ),
                        Expanded(
                          child: FilledButton(
                            onPressed: () => Navigator.pop(context, localType),
                            child: const Text('Apply Filter'),
                          ),
                        ),
                      ],
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

  if (result != null) {
    _typeFilter = result;
    notifyListeners();
  }
}

  Future<void> openPeriodSelector(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Period',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('All Time'),
                  leading: Radio<String>(
                    value: 'All Time',
                    groupValue: _period,
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                  onTap: () => Navigator.pop(context, 'All Time'),
                ),
                ListTile(
                  title: const Text('Today'),
                  leading: Radio<String>(
                    value: 'Today',
                    groupValue: _period,
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                  onTap: () => Navigator.pop(context, 'Today'),
                ),
                ListTile(
                  title: const Text('This Week'),
                  leading: Radio<String>(
                    value: 'This Week',
                    groupValue: _period,
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                  onTap: () => Navigator.pop(context, 'This Week'),
                ),
                ListTile(
                  title: const Text('This Month'),
                  leading: Radio<String>(
                    value: 'This Month',
                    groupValue: _period,
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                  onTap: () => Navigator.pop(context, 'This Month'),
                ),
                ListTile(
                  title: const Text('This Year'),
                  leading: Radio<String>(
                    value: 'This Year',
                    groupValue: _period,
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                  onTap: () => Navigator.pop(context, 'This Year'),
                ),
                ListTile(
                  title: const Text('Custom Range'),
                  leading: Radio<String>(
                    value: 'Custom Range',
                    groupValue: _period,
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                  onTap: () => Navigator.pop(context, 'Custom Range'),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (result == null) return;

    if (result == 'Custom Range') {
      final range = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
        initialDateRange: _customRange,
      );

      if (range != null) {
        _customRange = range;
        _period = 'Custom Range';
        notifyListeners();
      }
      return;
    }

    _period = result;
    _customRange = null;
    notifyListeners();
  }

  List<TransactionModel> get _filteredTransactions {
    final now = DateTime.now();

    return _transactions.where((tx) {
      // Search filter
      final title = _getTitle(tx).toLowerCase();
      final matchesSearch = title.contains(_searchQuery.toLowerCase());

      // Type filter - Now supports ALL, INCOME, EXPENSE, GET, GIVE, TRANSFER
      bool matchesType = _typeFilter == 'ALL';
      
      if (!matchesType) {
        if (_typeFilter == 'TRANSFER') {
          matchesType = tx.transactionType == 'SELF';
        } else {
          matchesType = tx.transactionType == _typeFilter;
        }
      }

      // Period filter
      bool matchesPeriod = true;

      switch (_period) {
        case 'All Time':
          break;

        case 'Today':
          matchesPeriod =
              tx.transactionDate.year == now.year &&
              tx.transactionDate.month == now.month &&
              tx.transactionDate.day == now.day;
          break;

        case 'This Week':
          final startOfWeek = DateTime(
            now.year,
            now.month,
            now.day,
          ).subtract(
            Duration(days: now.weekday - 1),
          );
          final endOfWeek = startOfWeek.add(
            const Duration(days: 7),
          );
          matchesPeriod =
              tx.transactionDate.isAfter(
                startOfWeek.subtract(const Duration(seconds: 1)),
              ) &&
              tx.transactionDate.isBefore(endOfWeek);
          break;

        case 'This Month':
          matchesPeriod =
              tx.transactionDate.year == now.year &&
              tx.transactionDate.month == now.month;
          break;

        case 'This Year':
          matchesPeriod =
              tx.transactionDate.year == now.year;
          break;

        case 'Custom Range':
          if (_customRange != null) {
            matchesPeriod =
                !tx.transactionDate.isBefore(_customRange!.start) &&
                !tx.transactionDate.isAfter(_customRange!.end);
          }
          break;
      }

      return matchesSearch && matchesType && matchesPeriod;
    }).toList();
  }

  List<TransactionModel> get _periodTransactions {
    final now = DateTime.now();

    return _transactions.where((tx) {
      bool matchesPeriod = true;

      switch (_period) {
        case 'All Time':
          break;

        case 'Today':
          matchesPeriod =
              tx.transactionDate.year == now.year &&
              tx.transactionDate.month == now.month &&
              tx.transactionDate.day == now.day;
          break;

        case 'This Week':
          final startOfWeek = DateTime(
            now.year,
            now.month,
            now.day,
          ).subtract(
            Duration(days: now.weekday - 1),
          );
          final endOfWeek = startOfWeek.add(
            const Duration(days: 7),
          );
          matchesPeriod =
              tx.transactionDate.isAfter(
                startOfWeek.subtract(const Duration(seconds: 1)),
              ) &&
              tx.transactionDate.isBefore(endOfWeek);
          break;

        case 'This Month':
          matchesPeriod =
              tx.transactionDate.year == now.year &&
              tx.transactionDate.month == now.month;
          break;

        case 'This Year':
          matchesPeriod =
              tx.transactionDate.year == now.year;
          break;

        case 'Custom Range':
          if (_customRange != null) {
            matchesPeriod =
                !tx.transactionDate.isBefore(_customRange!.start) &&
                !tx.transactionDate.isAfter(_customRange!.end);
          }
          break;
      }

      return matchesPeriod;
    }).toList();
  }

  double get incomeTotal {
    return _periodTransactions.fold(
      0.0,
      (sum, tx) => sum + (_getCashIn(tx) ?? 0),
    );
  }

  double get expenseTotal {
    return _periodTransactions.fold(
      0.0,
      (sum, tx) => sum + (_getCashOut(tx) ?? 0),
    );
  }

  String _getTitle(TransactionModel tx) {
    if (tx.partyId != null) {
      return ContactData.getContactName(tx.partyId);
    }
    
    if (tx.utilityId != null) {
      return UtilityData.getUtilityName(tx.utilityId);
    }
    
    if (tx.transactionType == 'SELF') {
      final fromAccount = AccountData.getAccountName(tx.accountId);
      final toAccount = AccountData.getAccountName(tx.toAccountId);
      return '$fromAccount → $toAccount';
    }
    
    if (tx.transactionType == 'GET') {
      return 'Received to ${AccountData.getAccountName(tx.accountId)}';
    }
    
    if (tx.transactionType == 'GIVE') {
      return 'Paid from ${AccountData.getAccountName(tx.accountId)}';
    }
    
    if (tx.transactionType == 'INCOME') {
      return 'Income to ${AccountData.getAccountName(tx.accountId)}';
    }
    
    if (tx.transactionType == 'EXPENSE') {
      return 'Expense from ${AccountData.getAccountName(tx.accountId)}';
    }
    
    return tx.transactionType ?? 'Transaction';
  }

  double? _getCashIn(TransactionModel tx) {
    if (tx.partyId != null && tx.transactionType == 'GET') {
      return tx.amount;
    }
    
    if (tx.utilityId != null && UtilityData.getUtilityType(tx.utilityId) == 'INCOME') {
      return tx.amount;
    }
    
    if (tx.transactionType == 'INCOME') {
      return tx.amount;
    }
    
    if (tx.transactionType == 'SELF' && tx.toAccountId != null) {
      return tx.amount;
    }
    
    return null;
  }

  double? _getCashOut(TransactionModel tx) {
    if (tx.partyId != null && tx.transactionType == 'GIVE') {
      return tx.amount;
    }
    
    if (tx.utilityId != null && UtilityData.getUtilityType(tx.utilityId) == 'EXPENSE') {
      return tx.amount;
    }
    
    if (tx.transactionType == 'EXPENSE') {
      return tx.amount;
    }
    
    if (tx.transactionType == 'SELF') {
      return tx.amount;
    }
    
    return null;
  }

  String? _getType(TransactionModel tx) {
    if (tx.partyId != null) {
      return tx.transactionType == 'GET' ? 'GET' : 'GIVE';
    }
    
    if (tx.utilityId != null) {
      return UtilityData.getUtilityType(tx.utilityId);
    }
    
    if (tx.transactionType == 'SELF') {
      return 'TRANSFER';
    }
    
    return tx.transactionType;
  }

  String? _getAccountName(TransactionModel tx) {
    if (tx.transactionType == 'SELF') {
      return null;
    }
    return AccountData.getAccountName(tx.accountId);
  }

  String? _getAccountPrefix(TransactionModel tx) {
    if (tx.transactionType == 'SELF') {
      return null;
    }
    
    if (tx.transactionType == 'GET' || tx.transactionType == 'INCOME') {
      return 'To';
    }
    
    if (tx.transactionType == 'GIVE' || tx.transactionType == 'EXPENSE') {
      return 'From';
    }
    
    return null;
  }

  // Getters for TransactionList builders
  String getTitle(TransactionModel tx) => _getTitle(tx);
  double? getCashIn(TransactionModel tx) => _getCashIn(tx);
  double? getCashOut(TransactionModel tx) => _getCashOut(tx);
  String? getType(TransactionModel tx) => _getType(tx);
  String? getAccountName(TransactionModel tx) => _getAccountName(tx);
  String? getAccountPrefix(TransactionModel tx) => _getAccountPrefix(tx);

  void resetFilters() {
    _searchQuery = '';
    _typeFilter = 'ALL';
    _period = 'Today';
    _customRange = null;
    notifyListeners();
  }
}