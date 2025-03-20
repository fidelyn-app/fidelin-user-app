class Store {
  final String id;
  final String businessName;
  final String? legalName;
  final String taxId;
  final String email;
  final String password; // Consider hashing password in a real application
  final String? avatarUrl;
  final String? phone;
  final bool active;
  final String stripeId;
  final Contacts contacts;
  final DateTime createdAt;
  final DateTime updatedAt;

  Store({
    required this.id,
    required this.businessName,
    this.legalName,
    required this.taxId,
    required this.email,
    required this.password,
    this.avatarUrl,
    this.phone,
    required this.active,
    required this.stripeId,
    required this.contacts,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return '''
        Store(
          id: $id,
          businessName: $businessName,
          legalName: ${legalName ?? 'Not provided'},
          taxId: $taxId,
          email: $email,
          password: (REDACTED - for security reasons),
          avatarUrl: $avatarUrl,
          phone: $phone,
          active: $active,
          stripeId: $stripeId,
          createdAt: $createdAt,
          updatedAt: $updatedAt
        )
        ''';
  }
}

class Contacts {
  final String? instagram;
  final String? phone;
  final String? site;
  final bool? whatsapp;

  Contacts({
    this.instagram,
    this.phone,
    this.site,
    this.whatsapp,
  });
}
