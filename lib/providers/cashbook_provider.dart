import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/data/account_data.dart';
import 'package:ledjify/models/transaction_model.dart';
import 'package:ledjify/services/transaction_display_service.dart';
import 'package:ledjify/services/transaction_service.dart';

class CashbookProvider extends ChangeNotifier {
  final TransactionService _transactionService = TransactionService();
  final TransactionDisplayService _displayService =
      TransactionDisplayService();

  List<TransactionModel> _transactions = [];

  String _searchQuery = '';
  String _typeFilter = 'ALL';
  String _period = 'Today';

  DateTimeRange? _customRange;

  List<TransactionModel> get transactions => _transactions;

  String get period => _period;

  Future<void> loadTransactions() async {
    final data = await _transactionService.getTransactions(
      types: ['INCOME', 'EXPENSE'],
    );

    _transactions = data;
    notifyListeners();
  }

  void search(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> openFilters(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.background,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('All'),
                onTap: () => Navigator.pop(context, 'ALL'),
              ),
              ListTile(
                title: const Text('Income'),
                onTap: () => Navigator.pop(context, 'INCOME'),
              ),
              ListTile(
                title: const Text('Expense'),
                onTap: () => Navigator.pop(context, 'EXPENSE'),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      _typeFilter = result;
      notifyListeners();
    }
  }

  Future<void> openPeriodSelector(
    BuildContext context,
  ) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.background,
      
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('All Time'),
                onTap: () =>
                    Navigator.pop(context, 'All Time'),
              ),
              ListTile(
                title: const Text('Today'),
                onTap: () =>
                    Navigator.pop(context, 'Today'),
              ),
              ListTile(
                title: const Text('This Week'),
                onTap: () =>
                    Navigator.pop(context, 'This Week'),
              ),
              ListTile(
                title: const Text('This Month'),
                onTap: () =>
                    Navigator.pop(context, 'This Month'),
              ),
              ListTile(
                title: const Text('This Year'),
                onTap: () =>
                    Navigator.pop(context, 'This Year'),
              ),
              ListTile(
                title: const Text('Custom Range'),
                onTap: () => Navigator.pop(
                  context,
                  'Custom Range',
                ),
              ),
            ],
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

  List<TransactionModel> get filteredTransactions {
    final now = DateTime.now();

    return _transactions.where((tx) {
      final title = getTitle(tx).toLowerCase();

      final matchesSearch = title.contains(
        _searchQuery.toLowerCase(),
      );

      final matchesType =
          _typeFilter == 'ALL' ||
          tx.transactionType == _typeFilter;

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
                startOfWeek.subtract(
                  const Duration(seconds: 1),
                ),
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
                !tx.transactionDate.isBefore(
                  _customRange!.start,
                ) &&
                !tx.transactionDate.isAfter(
                  _customRange!.end,
                );
          }
          break;
      }

      return matchesSearch &&
          matchesType &&
          matchesPeriod;
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
                startOfWeek.subtract(
                  const Duration(seconds: 1),
                ),
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
                !tx.transactionDate.isBefore(
                  _customRange!.start,
                ) &&
                !tx.transactionDate.isAfter(
                  _customRange!.end,
                );
          }
          break;
      }

      return matchesPeriod;
    }).toList();
  }

  double get incomeTotal {
    return _periodTransactions.fold(
      0.0,
      (sum, tx) =>
          sum + (_displayService.getCashIn(tx) ?? 0),
    );
  }

  double get expenseTotal {
    return _periodTransactions.fold(
      0.0,
      (sum, tx) =>
          sum + (_displayService.getCashOut(tx) ?? 0),
    );
  }

  String getTitle(TransactionModel tx) {
    if (tx.partyId != null) {
      return _displayService.getTitle(tx);
    }

    if (tx.utilityId != null) {
      return _displayService.getTitle(tx);
    }

    if (tx.transactionType == 'INCOME') {
      return 'Income to ${AccountData.getAccountName(tx.accountId)}';
    }

    if (tx.transactionType == 'EXPENSE') {
      return 'Expense from ${AccountData.getAccountName(tx.accountId)}';
    }

    return _displayService.getTitle(tx);
  }

  String? getAccountName(TransactionModel tx) {
    if (tx.transactionType == 'INCOME') {
      return AccountData.getAccountName(tx.accountId);
    }

    if (tx.transactionType == 'EXPENSE') {
      return AccountData.getAccountName(tx.accountId);
    }

    return null;
  }

  String? getAccountPrefix(TransactionModel tx) {
    if (tx.transactionType == 'INCOME') {
      return 'To';
    }

    if (tx.transactionType == 'EXPENSE') {
      return 'From';
    }

    return null;
  }

  String? getType(TransactionModel tx) {
    if (tx.partyId != null) {
      return tx.transactionType == 'GET'
          ? 'GET'
          : 'GIVE';
    }

    return _displayService.getDisplayType(tx);
  }

  double? getCashIn(TransactionModel tx) {
    return _displayService.getCashIn(tx);
  }

  double? getCashOut(TransactionModel tx) {
    return _displayService.getCashOut(tx);
  }
}