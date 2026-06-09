class ContactModel {
  final int id;
  final String name;
  final double amount;
  final PartyType type;
  final String imageUrl;

  const ContactModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    required this.imageUrl,
  });

  String get subtitle {
    switch (type) {
      case PartyType.get:
        return 'You will get';
      case PartyType.give:
        return 'You will give';
      case PartyType.settled:
        return 'Settled';
    }
  }
}

enum PartyType {
  get,
  give,
  settled,
}