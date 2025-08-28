import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class UnlockRoomUseCase extends BaseUseCase<String, dynamic> {
  final RoomRepository _roomRepository;
  UnlockRoomUseCase(this._roomRepository);

  @override
  Future<Either<Failure, dynamic>> execute(String params) async {
    return await _roomRepository.unlockRoom(params);
  }
}
