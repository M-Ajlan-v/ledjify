class AccountModel {
  final int id;
  final int userId;
  final String name;
  final String type;
  final String? accountNumber;
  final String? upiId;
  final String? wallet;
  final double openingBalance;
  final double currentBalance;

  const AccountModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    this.accountNumber,
    this.upiId,
    this.wallet,
    required this.openingBalance,
    required this.currentBalance,
  });
}