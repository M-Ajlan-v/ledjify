import '../models/transaction_model.dart';

final transactions = [

  // Arun
  TransactionModel(
    id: 1,
    userId: 1,
    partyId: 1,
    accountId: 1,
    transactionType: 'GET',
    amount: 1000,
    transactionDate: DateTime(2026, 6, 15, 10, 30),
  ),

  TransactionModel(
    id: 2,
    userId: 1,
    partyId: 1,
    accountId: 1,
    transactionType: 'GIVE',
    amount: 500,
    transactionDate: DateTime(2026, 6, 14, 9, 20),
  ),

  // Rahul
  TransactionModel(
    id: 3,
    userId: 1,
    partyId: 2,
    accountId: 1,
    transactionType: 'GIVE',
    amount: 2350,
    transactionDate: DateTime(2026, 6, 15, 12, 0),
  ),

  // Vineeth
  TransactionModel(
    id: 4,
    userId: 1,
    partyId: 3,
    accountId: 2,
    transactionType: 'GET',
    amount: 3200,
    transactionDate: DateTime(2026, 6, 13, 16, 0),
  ),

  // Akhil
  TransactionModel(
    id: 5,
    userId: 1,
    partyId: 4,
    accountId: 1,
    transactionType: 'GET',
    amount: 1000,
    transactionDate: DateTime(2026, 6, 10, 10, 0),
  ),

  TransactionModel(
    id: 6,
    userId: 1,
    partyId: 4,
    accountId: 1,
    transactionType: 'GIVE',
    amount: 1000,
    transactionDate: DateTime(2026, 6, 11, 10, 0),
  ),

  // Suresh
  TransactionModel(
    id: 7,
    userId: 1,
    partyId: 5,
    accountId: 3,
    transactionType: 'GET',
    amount: 7800,
    transactionDate: DateTime(2026, 6, 12, 14, 30),
  ),

  // Nithin
  TransactionModel(
    id: 8,
    userId: 1,
    partyId: 6,
    accountId: 1,
    transactionType: 'GIVE',
    amount: 1500,
    transactionDate: DateTime(2026, 6, 11, 18, 0),
  ),

  // Manu
  TransactionModel(
    id: 9,
    userId: 1,
    partyId: 7,
    accountId: 1,
    transactionType: 'GET',
    amount: 500,
    transactionDate: DateTime(2026, 6, 8, 9, 0),
  ),

  TransactionModel(
    id: 10,
    userId: 1,
    partyId: 7,
    accountId: 1,
    transactionType: 'GIVE',
    amount: 500,
    transactionDate: DateTime(2026, 6, 8, 17, 0),
  ),

  // Expenses & Income
  TransactionModel(
    id: 11,
    userId: 1,
    utilityId: 1,
    accountId: 1,
    transactionType: 'EXPENSE',
    amount: 300,
    transactionDate: DateTime(2026, 6, 14, 16, 0),
  ),

  TransactionModel(
    id: 12,
    userId: 1,
    utilityId: 2,
    accountId: 2,
    transactionType: 'INCOME',
    amount: 5000,
    transactionDate: DateTime(2026, 6, 14, 11, 0),
  ),

  TransactionModel(
    id: 13,
    userId: 1,
    utilityId: 3,
    accountId: 3,
    transactionType: 'EXPENSE',
    amount: 1200,
    transactionDate: DateTime(2026, 6, 13, 13, 0),
  ),

  TransactionModel(
    id: 14,
    userId: 1,
    utilityId: 4,
    accountId: 2,
    transactionType: 'INCOME',
    amount: 8500,
    transactionDate: DateTime(2026, 6, 12, 10, 0),
  ),

  TransactionModel(
    id: 15,
    userId: 1,
    utilityId: 5,
    accountId: 3,
    transactionType: 'EXPENSE',
    amount: 2200,
    transactionDate: DateTime(2026, 6, 11, 20, 0),
  ),

  // Transfers
  TransactionModel(
    id: 16,
    userId: 1,
    accountId: 1,
    toAccountId: 2,
    transactionType: 'SELF',
    amount: 1000,
    transactionDate: DateTime(2026, 6, 13, 18, 0),
  ),

  TransactionModel(
    id: 17,
    userId: 1,
    accountId: 2,
    toAccountId: 3,
    transactionType: 'SELF',
    amount: 2500,
    transactionDate: DateTime(2026, 6, 12, 19, 0),
  ),

  TransactionModel(
    id: 18,
    userId: 1,
    accountId: 3,
    toAccountId: 1,
    transactionType: 'SELF',
    amount: 500,
    transactionDate: DateTime(2026, 6, 10, 21, 0),
  ),
];