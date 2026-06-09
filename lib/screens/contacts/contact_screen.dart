import 'package:flutter/material.dart';
import 'package:ledjify/models/contact_model.dart';
import 'widgets/contact_filter_tabs.dart';
import 'widgets/contact_header.dart';
import 'widgets/contact_tile.dart';
import 'package:ledjify/data/contact_data.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int selectedIndex = 0;
  String searchQuery = '';

  final List<ContactModel> parties = ContactData.parties;

  List<ContactModel> get filteredParties {
    List<ContactModel> result;

    switch (selectedIndex) {
      case 1:
        result = parties.where((p) => p.type == PartyType.get).toList();
        break;

      case 2:
        result = parties.where((p) => p.type == PartyType.give).toList();
        break;

      case 3:
        result = parties.where((p) => p.type == PartyType.settled).toList();
        break;

      default:
        result = parties;
    }

    if (searchQuery.isNotEmpty) {
      result = result.where((party) {
        return party.name.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContactHeader(
          onSearchChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
        ContactFilterTabs(
          selectedIndex: selectedIndex,
          onSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.separated(
            itemCount: filteredParties.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ContactTile(
                key: ValueKey(filteredParties[index].id),
                party: filteredParties[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
