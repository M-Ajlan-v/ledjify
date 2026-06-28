import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/data/account_data.dart';
import 'package:ledjify/models/transaction_model.dart';
import 'package:ledjify/services/transaction_display_service.dart';
import 'package:ledjify/services/transaction_service.dart';

class CashbookHelper extends ChangeNotifier {
  final TransactionService _transactionService = TransactionService();
  final TransactionDisplayService _displayService = TransactionDisplayService();

  List<TransactionModel> _transactions = [];
  String _searchQuery = '';
  String _typeFilter = 'ALL';
  String _period = 'Day';
  DateTimeRange? _customRange;

  DateTime _selectedDay = DateTime.now();
  DateTime _selectedWeekDate = DateTime.now();
  DateTime _selectedMonth = DateTime.now();
  DateTime _selectedYear = DateTime.now();

  List<TransactionModel> get transactions => _transactions;
  String get period => _period;

  String get periodLabel {
    switch (_period) {
      case 'Day':
        return '${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}';

      case 'Week':
        final start = _selectedWeekDate.subtract(
          Duration(days: _selectedWeekDate.weekday - 1),
        );
        final end = start.add(const Duration(days: 6));
        return '${start.day}/${start.month} - ${end.day}/${end.month}';

      case 'Month':
        const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        return '${months[_selectedMonth.month]} ${_selectedMonth.year}';

      case 'Year':
        return '${_selectedYear.year}';

      case 'Custom Range':
        if (_customRange != null) {
          return '${_customRange!.start.day}/${_customRange!.start.month}/${_customRange!.start.year} - ${_customRange!.end.day}/${_customRange!.end.month}/${_customRange!.end.year}';
        }
        return 'Custom Range';

      default:
        return 'All Time';
    }
  }

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
                  title: const Text('Day'),
                  leading: Radio<String>(
                    value: 'Day',
                    groupValue: _period,
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                  onTap: () => Navigator.pop(context, 'Day'),
                ),
                ListTile(
                  title: const Text('Week'),
                  leading: Radio<String>(
                    value: 'Week',
                    groupValue: _period,
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                  onTap: () => Navigator.pop(context, 'Week'),
                ),
                ListTile(
                  title: const Text('Month'),
                  leading: Radio<String>(
                    value: 'Month',
                    groupValue: _period,
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                  onTap: () => Navigator.pop(context, 'Month'),
                ),
                ListTile(
                  title: const Text('Year'),
                  leading: Radio<String>(
                    value: 'Year',
                    groupValue: _period,
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                  onTap: () => Navigator.pop(context, 'Year'),
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

    if (result == 'All Time') {
      _period = 'All Time';
      _customRange = null;
      notifyListeners();
      return;
    }

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

    if (result == 'Day') {
      final date = await showDatePicker(
        context: context,
        initialDate: _selectedDay,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );

      if (date != null) {
        _selectedDay = date;
        _customRange = null;
        _period = 'Day';
        notifyListeners();
      }
      return;
    }

    if (result == 'Week') {
      final date = await showDatePicker(
        context: context,
        initialDate: _selectedWeekDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );

      if (date != null) {
        _selectedWeekDate = date;
        _customRange = null;
        _period = 'Week';
        notifyListeners();
      }
      return;
    }

    if (result == 'Month') {
      await _showMonthPicker(context);
      return;
    }

    if (result == 'Year') {
      await _showYearPicker(context);
      return;
    }
  }

  List<TransactionModel> get filteredTransactions {
    return _transactions.where((tx) {
      final title = getTitle(tx).toLowerCase();
      final matchesSearch = title.contains(_searchQuery.toLowerCase());

      bool matchesType = _typeFilter == 'ALL' || tx.transactionType == _typeFilter;

      bool matchesPeriod = true;

      switch (_period) {
        case 'All Time':
          break;

        case 'Day':
          matchesPeriod =
              tx.transactionDate.year == _selectedDay.year &&
              tx.transactionDate.month == _selectedDay.month &&
              tx.transactionDate.day == _selectedDay.day;
          break;

        case 'Week':
          final startOfWeek = DateTime(
            _selectedWeekDate.year,
            _selectedWeekDate.month,
            _selectedWeekDate.day,
          ).subtract(
            Duration(days: _selectedWeekDate.weekday - 1),
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

        case 'Month':
          matchesPeriod =
              tx.transactionDate.year == _selectedMonth.year &&
              tx.transactionDate.month == _selectedMonth.month;
          break;

        case 'Year':
          matchesPeriod =
              tx.transactionDate.year == _selectedYear.year;
          break;

        case 'Custom Range':
          if (_customRange != null) {
            final endDate = DateTime(
              _customRange!.end.year,
              _customRange!.end.month,
              _customRange!.end.day,
              23,
              59,
              59,
            );

            matchesPeriod =
                !tx.transactionDate.isBefore(_customRange!.start) &&
                !tx.transactionDate.isAfter(endDate);
          }
          break;
      }

      return matchesSearch && matchesType && matchesPeriod;
    }).toList();
  }

  List<TransactionModel> get _periodTransactions {
    return _transactions.where((tx) {
      bool matchesPeriod = true;

      switch (_period) {
        case 'All Time':
          break;

        case 'Day':
          matchesPeriod =
              tx.transactionDate.year == _selectedDay.year &&
              tx.transactionDate.month == _selectedDay.month &&
              tx.transactionDate.day == _selectedDay.day;
          break;

        case 'Week':
          final startOfWeek = DateTime(
            _selectedWeekDate.year,
            _selectedWeekDate.month,
            _selectedWeekDate.day,
          ).subtract(
            Duration(days: _selectedWeekDate.weekday - 1),
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

        case 'Month':
          matchesPeriod =
              tx.transactionDate.year == _selectedMonth.year &&
              tx.transactionDate.month == _selectedMonth.month;
          break;

        case 'Year':
          matchesPeriod =
              tx.transactionDate.year == _selectedYear.year;
          break;

        case 'Custom Range':
          if (_customRange != null) {
            final endDate = DateTime(
              _customRange!.end.year,
              _customRange!.end.month,
              _customRange!.end.day,
              23,
              59,
              59,
            );

            matchesPeriod =
                !tx.transactionDate.isBefore(_customRange!.start) &&
                !tx.transactionDate.isAfter(endDate);
          }
          break;
      }

      return matchesPeriod;
    }).toList();
  }

  double get incomeTotal {
    return _periodTransactions.fold(
      0.0,
      (sum, tx) => sum + (_displayService.getCashIn(tx) ?? 0),
    );
  }

  double get expenseTotal {
    return _periodTransactions.fold(
      0.0,
      (sum, tx) => sum + (_displayService.getCashOut(tx) ?? 0),
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
      return tx.transactionType == 'GET' ? 'GET' : 'GIVE';
    }

    return _displayService.getDisplayType(tx);
  }

  double? getCashIn(TransactionModel tx) {
    return _displayService.getCashIn(tx);
  }

  double? getCashOut(TransactionModel tx) {
    return _displayService.getCashOut(tx);
  }

  Future<void> _showMonthPicker(BuildContext context) async {
    int selectedMonth = _selectedMonth.month;
    int selectedYear = _selectedMonth.year;

    final result = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Select Month',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      value: selectedMonth,
                      decoration: const InputDecoration(
                        labelText: 'Month',
                      ),
                      items: const [
                        DropdownMenuItem(value: 1, child: Text('January')),
                        DropdownMenuItem(value: 2, child: Text('February')),
                        DropdownMenuItem(value: 3, child: Text('March')),
                        DropdownMenuItem(value: 4, child: Text('April')),
                        DropdownMenuItem(value: 5, child: Text('May')),
                        DropdownMenuItem(value: 6, child: Text('June')),
                        DropdownMenuItem(value: 7, child: Text('July')),
                        DropdownMenuItem(value: 8, child: Text('August')),
                        DropdownMenuItem(value: 9, child: Text('September')),
                        DropdownMenuItem(value: 10, child: Text('October')),
                        DropdownMenuItem(value: 11, child: Text('November')),
                        DropdownMenuItem(value: 12, child: Text('December')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      value: selectedYear,
                      decoration: const InputDecoration(
                        labelText: 'Year',
                      ),
                      items: List.generate(
                        20,
                        (index) {
                          final year = 2020 + index;
                          return DropdownMenuItem(
                            value: year,
                            child: Text('$year'),
                          );
                        },
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result == true) {
      _selectedMonth = DateTime(selectedYear, selectedMonth, 1);
      _customRange = null;
      _period = 'Month';
      notifyListeners();
    }
  }

  Future<void> _showYearPicker(BuildContext context) async {
    int selectedYear = _selectedYear.year;

    final result = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Select Year',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      value: selectedYear,
                      decoration: const InputDecoration(
                        labelText: 'Year',
                      ),
                      items: List.generate(
                        20,
                        (index) {
                          final year = 2020 + index;
                          return DropdownMenuItem(
                            value: year,
                            child: Text('$year'),
                          );
                        },
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result == true) {
      _selectedYear = DateTime(selectedYear, 1, 1);
      _customRange = null;
      _period = 'Year';
      notifyListeners();
    }
  }
}