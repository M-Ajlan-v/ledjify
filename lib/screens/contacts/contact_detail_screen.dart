import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/models/contact_model.dart';
import 'package:ledjify/models/transaction_model.dart';
import 'package:ledjify/screens/widgets/app_button.dart';
import 'package:ledjify/screens/widgets/transaction_list.dart';
import 'package:ledjify/services/transaction_service.dart';
import 'package:ledjify/services/transaction_display_service.dart';
import 'package:ledjify/data/account_data.dart';

class ContactDetailScreen extends StatefulWidget {
  final ContactModel contact;

  const ContactDetailScreen({
    super.key,
    required this.contact,
  });

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
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
      partyId: widget.contact.id,
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
    
    if (tx.transactionType == 'GET') {
      return 'Received to ${AccountData.getAccountName(tx.accountId)}';
    }
    
    if (tx.transactionType == 'GIVE') {
      return 'Paid from ${AccountData.getAccountName(tx.accountId)}';
    }
    
    return _displayService.getTitle(tx);
  }

  String? _getAccountName(TransactionModel tx) {
    if (tx.transactionType == 'GET') {
      return AccountData.getAccountName(tx.accountId);
    }
    
    if (tx.transactionType == 'GIVE') {
      return AccountData.getAccountName(tx.accountId);
    }
    
    return null;
  }

  String? _getAccountPrefix(TransactionModel tx) {
    if (tx.transactionType == 'GET') {
      return 'To';
    }
    
    if (tx.transactionType == 'GIVE') {
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
    final Color amountColor = switch (widget.contact.type) {
      PartyType.get => AppColors.get,
      PartyType.give => AppColors.give,
      PartyType.settled => Colors.blue,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              16,
              MediaQuery.paddingOf(context).top + 8,
              16,
              40,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 4),
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Text(
                    widget.contact.name[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.contact.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.contact.type == PartyType.get ? 'You get' : 
                    widget.contact.type == PartyType.give ? 'You give' : 'Settled',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -28),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      widget.contact.subtitle,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹ ${widget.contact.amount.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: amountColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SingleChildScrollView(
                child: TransactionList(
                  transactions: _transactions,
                  titleBuilder: _getTitle,
                  cashInBuilder: (tx) => _displayService.getCashIn(tx),
                  cashOutBuilder: (tx) => _displayService.getCashOut(tx),
                  typeBuilder: _getType,
                  accountNameBuilder: _getAccountName,
                  accountPrefixBuilder: _getAccountPrefix,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'GIVE',
                    icon: Icons.arrow_upward,
                    color: AppColors.give,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: 'GET',
                    icon: Icons.arrow_downward,
                    color: AppColors.get,
                    onPressed: () {},
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

//filter