import 'package:ledjify/data/transaction_data.dart';
import 'package:ledjify/models/transaction_model.dart';

class TransactionService {
  Future<List<TransactionModel>> getTransactions({
    int? partyId,
    String? type,
    List<String>? types,
  }) async {
    var result = transactions;
    
    if (partyId != null) {
      result = result.where((e) => e.partyId == partyId).toList();
    }
    if (type != null) {
      result = result.where((e) => e.transactionType == type).toList();
    }
    if (types != null) {
      result = result.where((e) => types.contains(e.transactionType)).toList();
    }
    
    // Sorting is already handled here
    result.sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
    
    return result;
  }
}