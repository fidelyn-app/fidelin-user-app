class Store {
  final String id;
  final String businessName;
  final String? legalName;
  final String taxId;
  final String email;
  final String? avatarUrl;
  final String? phone;
  final bool active;
  final String stripeId;
  final Contacts contacts;

  Store({
    required this.id,
    required this.businessName,
    this.legalName,
    required this.taxId,
    required this.email,
    this.avatarUrl,
    this.phone,
    required this.active,
    required this.stripeId,
    required this.contacts,
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
          avatarUrl: $avatarUrl,
          phone: $phone,
          active: $active,
          stripeId: $stripeId,
        )
        ''';
  }
}

class Contacts {
  final String? instagram;
  final String? phone;
  final String? site;
  final bool? whatsapp;

  Contacts({this.instagram, this.phone, this.site, this.whatsapp});
}
