import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/room_entity/room_settings_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetRoomSettingsUseCase extends BaseUseCase<String, RoomSettingsEntity> {
  final RoomRepository _roomRepository;
  GetRoomSettingsUseCase(this._roomRepository);

  @override
  Future<Either<Failure, RoomSettingsEntity>> execute(String params) async {
    return await _roomRepository.getRoomSettings(params);
  }
}
