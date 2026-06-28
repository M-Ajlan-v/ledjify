import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';
import 'package:ledjify/models/contact_model.dart';

class PartyCard extends StatelessWidget {
  final ContactModel contact;

  const PartyCard({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary,
            child: Text(
              contact.name[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (contact.phoneNumber != null)
                  Text(
                    contact.phoneNumber!,
                    style: const TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}