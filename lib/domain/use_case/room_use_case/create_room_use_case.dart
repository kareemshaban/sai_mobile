import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/create_room_params.dart';
import 'package:new_sai/domain/entity/room_entity/room_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class CreateRoomUseCase extends BaseUseCase<CreateRoomParams, RoomEntity> {
  final RoomRepository _roomRepository;
  CreateRoomUseCase(this._roomRepository);

  @override
  Future<Either<Failure, RoomEntity>> execute(CreateRoomParams params) async {
    return await _roomRepository.createRoom(params);
  }
}
