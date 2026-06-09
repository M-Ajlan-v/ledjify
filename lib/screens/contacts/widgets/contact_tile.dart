import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/models/party_model.dart';

class ContactTile extends StatelessWidget {
  final PartyModel party;

  const ContactTile({
    super.key,
    required this.party,
  });

  @override
  Widget build(BuildContext context) {
    Color amountColor;

    switch (party.type) {
      case PartyType.get:
        amountColor = Colors.green;
        break;
      case PartyType.give:
        amountColor = Colors.red;
        break;
      case PartyType.settled:
        amountColor = Colors.grey;
        break;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        child: Text(
          party.name[0],style: TextStyle(
          color: AppColors.secondary
        ),
        ),
      ),
      title: Text(party.name),
      subtitle: Text(party.subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '₹ ${party.amount.toStringAsFixed(0)}',
            style: TextStyle(
              color: amountColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}