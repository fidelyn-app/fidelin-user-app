import 'package:fidelyn_user_app/app/modules/home/data/data/dto/store_dto.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/store_entity.dart';

class StoreMapper {
  static Store toEntity(StoreDTO dto) {
    return Store(
      id: dto.id,
      businessName: dto.businessName,
      legalName: dto.legalName,
      taxId: dto.taxId,
      email: dto.email,
      avatarUrl: dto.avatarUrl,
      phone: dto.phone,
      active: dto.active,
      stripeId: dto.stripeId,
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
      avatarUrl: entity.avatarUrl,
      phone: entity.phone,
      active: entity.active,
      stripeId: entity.stripeId,
    );
  }
}
