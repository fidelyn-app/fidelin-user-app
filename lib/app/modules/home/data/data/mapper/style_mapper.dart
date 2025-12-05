import 'package:fidelyn_user_app/app/modules/home/data/data/dto/style_dto.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/style_entity.dart';
import 'package:fidelyn_user_app/utils/color_mapper.dart';

class StyleMapper {
  static Style toEntity(StyleDTO dto) {
    return Style(
      id: dto.id,
      colorPrimary: ColorMapper.hexToColor(dto.colorPrimary),
      colorSecondary: ColorMapper.hexToColor(dto.colorSecondary),
      pointShowNumbers: dto.pointShowNumbers,
      pointBorderRadius: dto.pointBorderRadius,
      backgroundUrl: dto.backgroundUrl,
      title: dto.title,
      subtitle: dto.subtitle,
    );
  }

  static StyleDTO toDto(Style entity) {
    return StyleDTO(
      id: entity.id,
      colorPrimary: ColorMapper.colorToHex(entity.colorPrimary),
      colorSecondary: ColorMapper.colorToHex(entity.colorSecondary),
      pointShowNumbers: entity.pointShowNumbers,
      pointBorderRadius: entity.pointBorderRadius,
      backgroundUrl: entity.backgroundUrl,
      title: entity.title,
      subtitle: entity.subtitle,
    );
  }
}
