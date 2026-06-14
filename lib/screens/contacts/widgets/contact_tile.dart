import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/models/contact_model.dart';
import 'package:ledjify/screens/contacts/contact_detail_screen.dart';

class ContactTile extends StatelessWidget {
  final ContactModel party;

  const ContactTile({super.key, required this.party});

  @override
  Widget build(BuildContext context) {
    Color amountColor;

    switch (party.type) {
      case PartyType.get:
        amountColor = AppColors.get;
        break;
      case PartyType.give:
        amountColor = AppColors.give;
        break;
      case PartyType.settled:
        amountColor = Colors.blue;
        break;
    }

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ContactDetailScreen(contact: party),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor:amountColor.withValues(alpha: 0.2),
        child: Text(
          party.name[0],
          style: const TextStyle(color: AppColors.secondary,
          fontWeight: FontWeight(800)
          ),
        ),
      ),
      title: Text(party.name,
      style: TextStyle(
        fontWeight: FontWeight(700)
      ),),
      subtitle: Text(party.subtitle,
      style: TextStyle(
        color: amountColor
      ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '₹ ${party.amount.toStringAsFixed(0)}',
            style: TextStyle(color: amountColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
