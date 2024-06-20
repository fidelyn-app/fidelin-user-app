import 'package:fidelin_user_app/app/modules/home/modules/cards/data/dto/store_dto.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/store_entity.dart';

class StoreMapper {
  static Store toEntity(StoreDTO dto) {
    return Store(
      id: dto.id,
      businessName: dto.businessName,
      legalName: dto.legalName,
      taxId: dto.taxId,
      email: dto.email,
      password: dto.password,
      avatarUrl: dto.avatarUrl,
      phone: dto.phone,
      active: dto.active,
      stripeId: dto.stripeId,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      contacts: Contacts(),
    );
  }

  static StoreDTO toDto(Store entity) {
    return StoreDTO(
      id: entity.id,
      businessName: entity.businessName,
      legalName: entity.legalName,
      taxId: entity.taxId,
      email: entity.email,
      password: entity.password,
      avatarUrl: entity.avatarUrl,
      phone: entity.phone,
      active: entity.active,
      stripeId: entity.stripeId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
