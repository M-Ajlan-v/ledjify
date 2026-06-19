import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String time;
  final String? type;
  final double? cashIn;
  final double? cashOut;
  final String? accountName;
  final String? accountPrefix;

  const TransactionTile({
    super.key,
    required this.title,
    required this.time,
    this.type,
    this.cashIn,
    this.cashOut,
    this.accountName,
    this.accountPrefix,
  });

  String _getAmountText() {
    if (type == 'TRANSFER') {
      return _formatAmount(cashOut ?? cashIn);
    }
    
    if (type == 'GET' || type == 'INCOME') {
      return '+ ${_formatAmount(cashIn)}';
    }
    
    if (type == 'GIVE' || type == 'EXPENSE') {
      return '- ${_formatAmount(cashOut)}';
    }
    
    if (cashIn != null && cashIn! > 0) {
      return '+ ${_formatAmount(cashIn)}';
    }
    
    if (cashOut != null && cashOut! > 0) {
      return '- ${_formatAmount(cashOut)}';
    }
    
    return '-';
  }

  String _formatAmount(double? value) {
    if (value == null) return '0';
    return value.toStringAsFixed(0);
  }

  Color _getAmountColor() {
    if (type == 'TRANSFER') {
      return AppColors.primary;
    }
    
    if (type == 'GET' || type == 'INCOME') {
      return AppColors.get;
    }
    
    if (type == 'GIVE' || type == 'EXPENSE') {
      return AppColors.give;
    }
    
    if (cashIn != null && cashIn! > 0) {
      return AppColors.get;
    }
    
    if (cashOut != null && cashOut! > 0) {
      return AppColors.give;
    }
    
    return Colors.black;
  }

  Color _getTypeColor() {
    if (type == 'TRANSFER') {
      return AppColors.primary;
    }
    if (type == 'GET' || type == 'INCOME') {
      return AppColors.get;
    }
    if (type == 'GIVE' || type == 'EXPENSE') {
      return AppColors.give;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.grey,
                        ),
                      ),
                      
                      if (accountName != null) ...[
                        const SizedBox(width: 6),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              accountPrefix == 'To' 
                                  ? Icons.arrow_downward 
                                  : Icons.arrow_upward,
                              size: 11,
                              color: accountPrefix == 'To'
                                  ? AppColors.get
                                  : AppColors.give,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              accountName!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: accountPrefix == 'To'
                                    ? AppColors.get
                                    : AppColors.give,
                              ),
                            ),
                          ],
                        ),
                      ],
                      
                      if (type != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor(),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            type!,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            color: Colors.black12,
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                _getAmountText(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _getAmountColor(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}