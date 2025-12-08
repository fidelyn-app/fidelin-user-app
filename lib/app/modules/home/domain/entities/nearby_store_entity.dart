import 'contact_entity.dart';
import 'location_entity.dart';

class NearbyStore {
  final String id;
  final String businessName;
  final String? legalName;
  final String taxId;
  final String email;
  final String? avatarUrl;
  final bool active;
  final String stripeId;
  final LocationEntity location;
  final ContactEntity contact;
  final double distance;

  NearbyStore({
    required this.id,
    required this.businessName,
    this.legalName,
    required this.taxId,
    required this.email,
    this.avatarUrl,
    required this.active,
    required this.stripeId,
    required this.location,
    required this.contact,
    required this.distance,
  });

  @override
  String toString() {
    return '''
        NearbyStore(
          id: $id,
          businessName: $businessName,
          legalName: ${legalName ?? 'Not provided'},
          taxId: $taxId,
          email: $email,
          avatarUrl: $avatarUrl,
          active: $active,
          stripeId: $stripeId,
          location: ${location.toString()},
          contact: ${contact.toString()},
          distance: $distance,
        )
        ''';
  }
}
