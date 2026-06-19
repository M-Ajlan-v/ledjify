import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'cashbook_period_selector.dart';

class CashbookSummaryCard extends StatelessWidget {
  final String period;
  final double income;
  final double expense;
  final VoidCallback onPeriodTap;

  const CashbookSummaryCard({
    super.key,
    required this.period,
    required this.income,
    required this.expense,
    required this.onPeriodTap,
  });

  @override
  Widget build(BuildContext context) {
    final balance = income - expense;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Summary',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              CashbookPeriodSelector(
                value: period,
                onTap: onPeriodTap,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _tile(
                  'Income',
                  income,
                  AppColors.get,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _tile(
                  'Expense',
                  expense,
                  AppColors.give,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  'Net Cash Flow',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${balance.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: balance >= 0
                        ? AppColors.get
                        : AppColors.give,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(
    String title,
    double amount,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '₹${amount.toStringAsFixed(0)}',
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}