import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/models/transaction_model.dart';
import 'package:ledjify/screens/widgets/transaction_list.dart';
import 'package:ledjify/services/transaction_service.dart';
import 'package:ledjify/services/transaction_display_service.dart';
import 'package:ledjify/data/account_data.dart';

class CashbookScreen extends StatefulWidget {
  const CashbookScreen({super.key});

  @override
  State<CashbookScreen> createState() => _CashbookScreenState();
}

class _CashbookScreenState extends State<CashbookScreen> {
  final TransactionService _transactionService = TransactionService();
  final TransactionDisplayService _displayService = TransactionDisplayService();
  List<TransactionModel> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final data = await _transactionService.getTransactions(
      types: ['INCOME', 'EXPENSE'],  
    );
    
    setState(() {
      _transactions = data;
    });
  }

  String _getTitle(TransactionModel tx) {
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

  String? _getAccountName(TransactionModel tx) {
    if (tx.transactionType == 'INCOME') {
      return AccountData.getAccountName(tx.accountId);
    }
    
    if (tx.transactionType == 'EXPENSE') {
      return AccountData.getAccountName(tx.accountId);
    }
    
    return null;
  }

  String? _getAccountPrefix(TransactionModel tx) {
    if (tx.transactionType == 'INCOME') {
      return 'To';
    }
    
    if (tx.transactionType == 'EXPENSE') {
      return 'From';
    }
    
    return null;
  }

  String? _getType(TransactionModel tx) {
    if (tx.partyId != null) {
      return tx.transactionType == 'GET' ? 'GET' : 'GIVE';
    }
    
    if (tx.utilityId != null) {
      return _displayService.getDisplayType(tx);
    }
    
    return _displayService.getDisplayType(tx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Cashbook',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: TransactionList(
              transactions: _transactions,
              titleBuilder: _getTitle,
              cashInBuilder: (tx) => _displayService.getCashIn(tx),
              cashOutBuilder: (tx) => _displayService.getCashOut(tx),
              typeBuilder: _getType,
              accountNameBuilder: _getAccountName,
              accountPrefixBuilder: _getAccountPrefix,
            ),
          )
        ],
      ),
    );
  }
}