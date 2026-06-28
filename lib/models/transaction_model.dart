class TransactionModel {
  final int id;
  final int userId;
  final int? partyId;
  final int? utilityId;
  final int accountId;
  final int? toAccountId;
  final String transactionType;
  final double amount;
  final DateTime transactionDate;
  final String? details;
  final String? invoiceUrl;

  const TransactionModel({
    required this.id,
    required this.userId,
    this.partyId,
    this.utilityId,
    required this.accountId,
    this.toAccountId,
    required this.transactionType,
    required this.amount,
    required this.transactionDate,
    this.details,
    this.invoiceUrl
  });
}