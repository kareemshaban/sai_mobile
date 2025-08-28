import 'package:new_sai/domain/entity/settings_entity/unique_id_entity.dart';

class SettingMarketEntity {
  num goldValue;
  List<UniqueIdEntity> room;
  List<UniqueIdEntity> user;

  SettingMarketEntity({
    required this.goldValue,
    required this.room,
    required this.user,
  });
}
