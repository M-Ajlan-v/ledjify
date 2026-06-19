import 'package:flutter/material.dart';

class CashbookPeriodSelector extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const CashbookPeriodSelector({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}