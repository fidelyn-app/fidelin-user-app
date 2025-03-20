import 'package:fidelin_user_app/app/modules/home/data/data/dto/style_dto.dart';
import 'package:fidelin_user_app/app/modules/home/domain/entities/style_entity.dart';
import 'package:fidelin_user_app/utils/color_mapper.dart';

class StyleMapper {
  static Style toEntity(StyleDTO dto) {
    return Style(
      id: dto.id,
      pointColor: ColorMapper.hexToColor(dto.pointColor),
      pointShowNumbers: dto.pointShowNumbers,
      pointBorderRadius: double.parse(dto.pointBorderRadius),
      pointBorderSize: double.parse(dto.pointBorderSize),
      pointColumnSize: dto.pointColumnSize,
      pointBackgroundUrl: dto.pointBackgroundUrl,
      backgroundUrl: dto.backgroundUrl,
      backgroundColor: ColorMapper.hexToColor(dto.backgroundColor),
      title: dto.title,
      subtitle: dto.subtitle,
    );
  }

  static StyleDTO toDto(Style entity) {
    return StyleDTO(
      id: entity.id.toString(),
      pointColor: ColorMapper.colorToHex(entity.pointColor),
      pointShowNumbers: entity.pointShowNumbers,
      pointBorderSize: entity.pointBorderSize.toString(),
      pointBorderRadius: entity.pointBorderRadius.toString(),
      pointColumnSize: entity.pointColumnSize,
      pointBackgroundUrl: entity.pointBackgroundUrl,
      backgroundUrl: entity.backgroundUrl,
      backgroundColor: ColorMapper.colorToHex(entity.backgroundColor),
      title: entity.title,
      subtitle: entity.subtitle,
    );
  }
}
