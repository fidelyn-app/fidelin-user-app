import 'package:fidelin_user_app/app/modules/home/data/data/dto/point_dto.dart';
import 'package:fidelin_user_app/app/modules/home/domain/entities/point_entity.dart';

class PointMapper {
  static Point toEntity(PointDTO dto) {
    return Point(
      id: dto.id,
      used: dto.used,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  static PointDTO toDto(Point entity) {
    return PointDTO(
      id: entity.id,
      used: entity.used,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
