import 'package:fidelyn_user_app/app/modules/home/data/data/dto/store_contact_dto.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/contact_entity.dart';

class ContactMapper {
  static ContactEntity toEntity(StoreContactDTO dto) {
    return ContactEntity(
      id: dto.id,
      primaryPhone: dto.primaryPhone,
      secondaryPhone: dto.secondaryPhone,
      whatsapp: dto.whatsapp,
      email: dto.email,
      website: dto.website,
      instagram: dto.instagram,
      facebook: dto.facebook,
      telegram: dto.telegram,
      tiktok: dto.tiktok,
      youtube: dto.youtube,
    );
  }

  static StoreContactDTO toDto(ContactEntity entity) {
    return StoreContactDTO(
      id: entity.id,
      primaryPhone: entity.primaryPhone,
      secondaryPhone: entity.secondaryPhone,
      whatsapp: entity.whatsapp,
      email: entity.email,
      website: entity.website,
      instagram: entity.instagram,
      facebook: entity.facebook,
      telegram: entity.telegram,
      tiktok: entity.tiktok,
      youtube: entity.youtube,
    );
  }
}
