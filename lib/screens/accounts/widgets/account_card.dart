import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/models/account_model.dart';

class AccountCard extends StatelessWidget {
  final AccountModel account;

  const AccountCard({
    super.key,
    required this.account,
  });

  IconData get icon {
    switch (account.type) {
      case 'BANK':
        return Icons.account_balance;
      case 'UPI':
        return Icons.qr_code_2;
      case 'WALLET':
        return Icons.account_balance_wallet;
      default:
        return Icons.payments_outlined;
    }
  }

  Color get color {
    switch (account.type) {
      case 'BANK':
        return Colors.blue;
      case 'UPI':
        return Colors.deepPurple;
      case 'WALLET':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  String get subtitle {
    if (account.type == 'BANK' &&
        account.accountNumber != null) {
      return '•••• ${account.accountNumber}';
    }

    if (account.type == 'UPI' &&
        account.upiId != null) {
      return account.upiId!;
    }

    if (account.type == 'WALLET' &&
        account.wallet != null) {
      return account.wallet!;
    }

    return account.type;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
            child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Current Balance',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${account.currentBalance.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: PopupMenuButton(
              color: AppColors.background,
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}