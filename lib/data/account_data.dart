import '../models/account_model.dart';

const accounts = [
  AccountModel(
    id: 1,
    userId: 1,
    name: 'Cash',
    type: 'CASH',
    openingBalance: 10000,
    currentBalance: 18050,
  ),
  AccountModel(
    id: 2,
    userId: 1,
    name: 'SBI Bank',
    type: 'BANK',
    accountNumber: 'XXXX1234',
    openingBalance: 50000,
    currentBalance: 51500,
  ),
  AccountModel(
    id: 3,
    userId: 1,
    name: 'Google Pay',
    type: 'UPI',
    upiId: 'aju@sbi',
    openingBalance: 2000,
    currentBalance: 3750,
  ),
  AccountModel(
    id: 4,
    userId: 1,
    name: 'Paytm Wallet',
    type: 'WALLET',
    wallet: '9876543210',
    openingBalance: 1000,
    currentBalance: 850,
  ),
];

class AccountData {
  static String getAccountName(int? accountId) {
    if (accountId == null) return 'Unknown';
    final account = accounts.firstWhere(
      (acc) => acc.id == accountId,
      orElse: () => AccountModel(
        id: accountId,
        userId: 1,
        name: 'Account $accountId',
        type: 'UNKNOWN',
        openingBalance: 0,
        currentBalance: 0,
      ),
    );
    return account.name;
  }
  
  static AccountModel? getAccount(int? accountId) {
    if (accountId == null) return null;
    try {
      return accounts.firstWhere((acc) => acc.id == accountId);
    } catch (e) {
      return null;
    }
  }
}