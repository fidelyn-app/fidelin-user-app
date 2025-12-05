import 'package:fidelyn_user_app/app/core/domain/entities/user_entity.dart';

import '../dto/user_dto.dart';

class UserMapper {
  static UserEntity mapDTOtoEntity(UserDTO dto) {
    return UserEntity(
      id: dto.id,
      name: dto.name,
      email: dto.email,
      phone: dto.phone,
      avatarUrl: dto.avatarUrl,
    );
  }

  static UserDTO mapEntityToDTO(UserEntity entity) {
    return UserDTO(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      avatarUrl: entity.avatarUrl,
    );
  }
}
