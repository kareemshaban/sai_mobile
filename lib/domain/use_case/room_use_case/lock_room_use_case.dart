import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/lock_room_params.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class LockRoomUseCase extends BaseUseCase<LockRoomParams, dynamic> {
  final RoomRepository _roomRepository;
  LockRoomUseCase(this._roomRepository);

  @override
  Future<Either<Failure, dynamic>> execute(LockRoomParams params) async {
    return await _roomRepository.lockRoom(params);
  }
}
