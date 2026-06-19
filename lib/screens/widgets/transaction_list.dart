import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transaction_model.dart';
import 'transaction_tile.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;
  final String Function(TransactionModel) titleBuilder;
  final double? Function(TransactionModel) cashInBuilder;
  final double? Function(TransactionModel) cashOutBuilder;
  final String? Function(TransactionModel)? typeBuilder;
  final String? Function(TransactionModel)? accountNameBuilder;
  final String? Function(TransactionModel)? accountPrefixBuilder;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.titleBuilder,
    required this.cashInBuilder,
    required this.cashOutBuilder,
    this.typeBuilder,
    this.accountNameBuilder,
    this.accountPrefixBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<TransactionModel>>{};

    for (final tx in transactions) {
      final key = DateFormat('dd MMM yyyy').format(tx.transactionDate);
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(tx);
    }

    final dates = grouped.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final date = dates[index];
        final items = grouped[date]!;

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  children: [
                    ...List.generate(
                      items.length,
                      (i) {
                        final tx = items[i];

                        return Column(
                          children: [
                            TransactionTile(
                              title: titleBuilder(tx),
                              time: DateFormat('hh:mm a').format(
                                tx.transactionDate,
                              ),
                              type: typeBuilder?.call(tx),
                              cashIn: cashInBuilder(tx),
                              cashOut: cashOutBuilder(tx),
                              accountName: accountNameBuilder?.call(tx),
                              accountPrefix: accountPrefixBuilder?.call(tx),
                            ),
                            if (i != items.length - 1)
                              const Divider(height: 1),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}