import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/update_room_settings_params.dart';
import 'package:new_sai/domain/entity/room_entity/joined_room_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class UpdateRoomSettingsUseCase
    extends BaseUseCase<UpdateRoomSettingsParams, JoinedRoomEntity> {
  final RoomRepository _roomRepository;
  UpdateRoomSettingsUseCase(this._roomRepository);

  @override
  Future<Either<Failure, JoinedRoomEntity>> execute(
      UpdateRoomSettingsParams params) async {
    return await _roomRepository.updateRoomSettings(params);
  }
}
