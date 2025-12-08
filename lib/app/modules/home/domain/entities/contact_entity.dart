class ContactEntity {
  final String id;
  final String? primaryPhone;
  final String? secondaryPhone;
  final String? whatsapp;
  final String email;
  final String? website;
  final String? instagram;
  final String? facebook;
  final String? telegram;
  final String? tiktok;
  final String? youtube;

  ContactEntity({
    required this.id,
    this.primaryPhone,
    this.secondaryPhone,
    this.whatsapp,
    required this.email,
    this.website,
    this.instagram,
    this.facebook,
    this.telegram,
    this.tiktok,
    this.youtube,
  });

  @override
  String toString() {
    return '''
      ContactEntity(
        id: $id,
        primaryPhone: ${primaryPhone ?? 'null'},
        secondaryPhone: ${secondaryPhone ?? 'null'},
        whatsapp: ${whatsapp ?? 'null'},
        email: $email,
        website: ${website ?? 'null'},
        instagram: ${instagram ?? 'null'},
        facebook: ${facebook ?? 'null'},
        telegram: ${telegram ?? 'null'},
        tiktok: ${tiktok ?? 'null'},
        youtube: ${youtube ?? 'null'},
      )
    ''';
  }
}
