class LocationEntity {
  final String id;
  final String postalCode;
  final String street;
  final String complement;
  final String? unit;
  final String district;
  final String city;
  final String state;
  final String stateName;
  final String region;
  final String ddd;
  final CoordinatesEntity? coordinates;

  LocationEntity({
    required this.id,
    required this.postalCode,
    required this.street,
    required this.complement,
    this.unit,
    required this.district,
    required this.city,
    required this.state,
    required this.stateName,
    required this.region,
    required this.ddd,
    required this.coordinates,
  });

  @override
  String toString() {
    return '''
      LocationEntity(
        id: $id,
        postalCode: $postalCode,
        street: $street,
        complement: $complement,
        unit: ${unit ?? 'null'},
        district: $district,
        city: $city,
        state: $state,
        stateName: $stateName,
        region: $region,
        ddd: $ddd,
        coordinates: $coordinates,
      )
    ''';
  }
}

class CoordinatesEntity {
  final double latitude;
  final double longitude;

  CoordinatesEntity({required this.latitude, required this.longitude});

  @override
  String toString() {
    return '''
      CoordinatesEntity(
        latitude: $latitude,
        longitude: $longitude,
      )
    ''';
  }
}
