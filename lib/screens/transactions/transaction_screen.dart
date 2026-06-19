import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/models/transaction_model.dart';
import 'package:ledjify/services/transaction_service.dart';
import 'package:ledjify/screens/widgets/transaction_list.dart';
import 'package:ledjify/data/contact_data.dart';
import 'package:ledjify/data/utility_data.dart';
import 'package:ledjify/data/account_data.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TransactionService _service = TransactionService();

  late Future<List<TransactionModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getTransactions();
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
      body: FutureBuilder<List<TransactionModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No transactions found'),
            );
          }

          final transactions = snapshot.data!;

          return TransactionList(
            transactions: transactions,
            titleBuilder: _getTitle,
            cashInBuilder: _getCashIn,
            cashOutBuilder: _getCashOut,
            typeBuilder: _getType,
            accountNameBuilder: _getAccountName,
            accountPrefixBuilder: _getAccountPrefix,
          );
        },
      ),
    );
  }
}