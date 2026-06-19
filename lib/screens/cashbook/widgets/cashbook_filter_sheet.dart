import 'package:flutter/material.dart';

class CashbookFilterSheet extends StatefulWidget {
  const CashbookFilterSheet({super.key});

  @override
  State<CashbookFilterSheet> createState() =>
      _CashbookFilterSheetState();
}

class _CashbookFilterSheetState
    extends State<CashbookFilterSheet> {
  String type = 'ALL';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Filters',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            RadioListTile(
              value: 'ALL',
              groupValue: type,
              title: const Text('All'),
              onChanged: (value) {
                setState(() {
                  type = value!;
                });
              },
            ),
            RadioListTile(
              value: 'INCOME',
              groupValue: type,
              title: const Text('Income'),
              onChanged: (value) {
                setState(() {
                  type = value!;
                });
              },
            ),
            RadioListTile(
              value: 'EXPENSE',
              groupValue: type,
              title: const Text('Expense'),
              onChanged: (value) {
                setState(() {
                  type = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}