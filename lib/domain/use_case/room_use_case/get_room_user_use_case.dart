import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/room_user_params.dart';
import 'package:new_sai/domain/entity/room_entity/room_user_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetRoomUserUseCase extends BaseUseCase<RoomUserParams, RoomUserEntity> {
  final RoomRepository _roomRepository;
  GetRoomUserUseCase(this._roomRepository);

  @override
  Future<Either<Failure, RoomUserEntity>> execute(RoomUserParams params) async {
    return await _roomRepository.getRoomUser(params);
  }
}
