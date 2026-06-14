
import 'package:ledjify/models/account_model.dart';

final accounts = [
  const AccountModel(
    id: 1,
    userId: 1,
    name: 'Cash',
    type: 'CASH',
    openingBalance: 5000,
    currentBalance: 3800,
  ),
  const AccountModel(
    id: 2,
    userId: 1,
    name: 'HDFC Bank',
    type: 'BANK',
    accountNumber: '5678',
    openingBalance: 10000,
    currentBalance: 12450,
  ),
  const AccountModel(
    id: 3,
    userId: 1,
    name: 'Google Pay',
    type: 'UPI',
    upiId: 'aju@okicici',
    openingBalance: 0,
    currentBalance: 2200,
  ),
  const AccountModel(
    id: 4,
    userId: 1,
    name: 'SBI Bank',
    type: 'BANK',
    accountNumber: '2698',
    openingBalance: 1450,
    currentBalance: 12450,
  ),
];