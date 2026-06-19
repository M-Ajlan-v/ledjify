import '../models/contact_model.dart';

class ContactData {
  static const List<ContactModel> parties = [
    ContactModel(
      id: 1,
      name: 'Arun Kumar',
      amount: 500,
      type: PartyType.get,
      imageUrl: '',
    ),
    ContactModel(
      id: 2,
      name: 'Rahul',
      amount: 2350,
      type: PartyType.give,
      imageUrl: '',
    ),
    ContactModel(
      id: 3,
      name: 'Vineeth',
      amount: 3200,
      type: PartyType.get,
      imageUrl: '',
    ),
    ContactModel(
      id: 4,
      name: 'Akhil',
      amount: 0,
      type: PartyType.settled,
      imageUrl: '',
    ),
    ContactModel(
      id: 5,
      name: 'Suresh',
      amount: 7800,
      type: PartyType.get,
      imageUrl: '',
    ),
    ContactModel(
      id: 6,
      name: 'Nithin',
      amount: 1500,
      type: PartyType.give,
      imageUrl: '',
    ),
    ContactModel(
      id: 7,
      name: 'Manu',
      amount: 0,
      type: PartyType.settled,
      imageUrl: '',
    ),
  ];

  static String getContactName(int? partyId) {
    if (partyId == null) return '';
    final contact = parties.firstWhere(
      (c) => c.id == partyId,
      orElse: () => ContactModel(
        id: -1,
        name: 'Unknown',
        amount: 0,
        type: PartyType.settled,
        imageUrl: '',
      ),
    );
    return contact.name;
  }

  static PartyType getContactType(int? partyId) {
    if (partyId == null) return PartyType.settled;
    final contact = parties.firstWhere(
      (c) => c.id == partyId,
      orElse: () => ContactModel(
        id: -1,
        name: 'Unknown',
        amount: 0,
        type: PartyType.settled,
        imageUrl: '',
      ),
    );
    return contact.type;
  }
}