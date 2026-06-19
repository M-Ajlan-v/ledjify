import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/models/transaction_model.dart';
import 'package:ledjify/screens/widgets/app_button.dart';
import 'package:ledjify/screens/widgets/transaction_list.dart';
import 'package:ledjify/services/transaction_service.dart';
import 'package:ledjify/services/transaction_display_service.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TransactionService _transactionService = TransactionService();
  final TransactionDisplayService _displayService = TransactionDisplayService();
  List<TransactionModel> _transfers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransfers();
  }

  Future<void> _loadTransfers() async {
    setState(() {
      _isLoading = true;
    });
    
    final allTransactions = await _transactionService.getTransactions();
    final transfers = allTransactions.where((tx) => tx.transactionType == 'SELF').toList();
    
    setState(() {
      _transfers = transfers;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: const Text('Transfers'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _transfers.isEmpty
                    ? const Center(
                        child: Text(
                          'No transfers found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : TransactionList(
                        transactions: _transfers,
                        titleBuilder: (tx) => _displayService.getTitle(tx),
                        cashInBuilder: (tx) => _displayService.getCashIn(tx),
                        cashOutBuilder: (tx) => _displayService.getCashOut(tx),
                        typeBuilder: (tx) => _displayService.getDisplayType(tx),
                      ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: AppButton(
              text: 'TRANSFER',
              icon: Icons.swap_horiz,
              color: AppColors.primary,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}