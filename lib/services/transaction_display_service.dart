import 'package:ledjify/models/transaction_model.dart';
import 'package:ledjify/data/contact_data.dart';
import 'package:ledjify/data/utility_data.dart';
import 'package:ledjify/data/account_data.dart';

class TransactionDisplayService {
  String getTitle(TransactionModel tx) {
    if (tx.utilityId != null) {
      return UtilityData.getUtilityName(tx.utilityId);
    }
    
    if (tx.partyId != null) {
      return ContactData.getContactName(tx.partyId);
    }
    
    if (tx.toAccountId != null && tx.transactionType == 'SELF') {
      return '${AccountData.getAccountName(tx.accountId)} → ${AccountData.getAccountName(tx.toAccountId)}';
    }
    
    if (tx.transactionType == 'GET') {
      final accountName = AccountData.getAccountName(tx.accountId);
      return 'Received to $accountName';
    }
    
    if (tx.transactionType == 'GIVE') {
      final accountName = AccountData.getAccountName(tx.accountId);
      return 'Paid from $accountName';
    }
    
    if (tx.transactionType == 'INCOME') {
      final accountName = AccountData.getAccountName(tx.accountId);
      return 'Income to $accountName';
    }
    
    if (tx.transactionType == 'EXPENSE') {
      final accountName = AccountData.getAccountName(tx.accountId);
      return 'Expense from $accountName';
    }
    
    return tx.transactionType;
  }
  
  String getDisplayType(TransactionModel tx) {
    if (tx.utilityId != null) {
      return UtilityData.getUtilityType(tx.utilityId);
    }
    
    if (tx.partyId != null) {
      return tx.transactionType == 'GET' ? 'GET' : 'GIVE';
    }
    
    if (tx.toAccountId != null && tx.transactionType == 'SELF') {
      return 'TRANSFER';
    }
    
    return tx.transactionType;
  }
  
  double? getCashIn(TransactionModel tx) {
    if (tx.utilityId != null) {
      return UtilityData.getUtilityType(tx.utilityId) == 'INCOME' 
          ? tx.amount 
          : null;
    }
    
    if (tx.partyId != null && tx.transactionType == 'GET') {
      return tx.amount;
    }
    
    if (tx.transactionType == 'INCOME') {
      return tx.amount;
    }
    
    return null;
  }
  
  double? getCashOut(TransactionModel tx) {
    if (tx.utilityId != null) {
      return UtilityData.getUtilityType(tx.utilityId) == 'EXPENSE' 
          ? tx.amount 
          : null;
    }
    
    if (tx.partyId != null && tx.transactionType == 'GIVE') {
      return tx.amount;
    }
    
    if (tx.transactionType == 'EXPENSE') {
      return tx.amount;
    }
    
    if (tx.toAccountId != null && tx.transactionType == 'SELF') {
      return tx.amount;
    }
    
    return null;
  }
  
  String getAccountInfo(TransactionModel tx) {
    if (tx.transactionType == 'SELF') {
      return '${AccountData.getAccountName(tx.accountId)} → ${AccountData.getAccountName(tx.toAccountId)}';
    }
    return AccountData.getAccountName(tx.accountId);
  }
}