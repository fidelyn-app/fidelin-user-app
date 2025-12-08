import 'package:fidelyn_user_app/app/modules/home/data/data/dto/nearby_store_dto.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/mapper/contact_mapper.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/mapper/location_mapper.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/nearby_store_entity.dart';

class NearbyStoreMapper {
  static NearbyStore toEntity(NearbyStoreDTO dto) {
    return NearbyStore(
      id: dto.id,
      businessName: dto.businessName,
      legalName: dto.legalName,
      taxId: dto.taxId,
      email: dto.email,
      avatarUrl: dto.avatarUrl,
      active: dto.active,
      stripeId: dto.stripeId,
      location: LocationMapper.toEntity(dto.location),
      contact: ContactMapper.toEntity(dto.contact),
      distance: dto.distance,
    );
  }

  static NearbyStoreDTO toDto(NearbyStore entity) {
    return NearbyStoreDTO(
      id: entity.id,
      businessName: entity.businessName,
      legalName: entity.legalName,
      taxId: entity.taxId,
      email: entity.email,
      avatarUrl: entity.avatarUrl,
      active: entity.active,
      stripeId: entity.stripeId,
      location: LocationMapper.toDto(entity.location),
      contact: ContactMapper.toDto(entity.contact),
      distance: entity.distance,
    );
  }
}
