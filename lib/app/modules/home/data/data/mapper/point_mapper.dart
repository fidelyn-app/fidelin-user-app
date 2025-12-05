import 'package:fidelyn_user_app/app/modules/home/data/data/dto/point_dto.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/point_entity.dart';

class PointMapper {
  static Point toEntity(PointDTO dto) {
    return Point(id: dto.id, used: dto.used);
  }

  static PointDTO toDto(Point entity) {
    return PointDTO(id: entity.id, used: entity.used);
  }
}
