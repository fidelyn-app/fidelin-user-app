import 'package:fidelyn_user_app/app/modules/home/data/data/dto/location_coordinates_dto.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/dto/store_location_dto.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/location_entity.dart';

class LocationMapper {
  static LocationEntity toEntity(StoreLocationDTO dto) {
    return LocationEntity(
      id: dto.id,
      postalCode: dto.postalCode,
      street: dto.street,
      complement: dto.complement,
      unit: dto.unit,
      district: dto.district,
      city: dto.city,
      state: dto.state,
      stateName: dto.stateName,
      region: dto.region,
      ddd: dto.ddd,
      coordinates:
          dto.coordinates != null
              ? CoordinatesMapper.toEntity(dto.coordinates!)
              : null,
    );
  }

  static StoreLocationDTO toDto(LocationEntity entity) {
    return StoreLocationDTO(
      id: entity.id,
      postalCode: entity.postalCode,
      street: entity.street,
      complement: entity.complement,
      unit: entity.unit,
      district: entity.district,
      city: entity.city,
      state: entity.state,
      stateName: entity.stateName,
      region: entity.region,
      ddd: entity.ddd,
      coordinates:
          entity.coordinates != null
              ? CoordinatesMapper.toDto(entity.coordinates!)
              : null,
    );
  }
}

class CoordinatesMapper {
  static CoordinatesEntity toEntity(LocationCoordinatesDTO dto) {
    return CoordinatesEntity(latitude: dto.latitude, longitude: dto.longitude);
  }

  static LocationCoordinatesDTO toDto(CoordinatesEntity entity) {
    return LocationCoordinatesDTO(
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
