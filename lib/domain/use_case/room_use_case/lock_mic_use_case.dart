import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/lock_unlock_mic_params.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class LockMicUseCase extends BaseUseCase<LockUnlockMicParams, dynamic> {
  final RoomRepository _roomRepository;
  LockMicUseCase(this._roomRepository);

  @override
  Future<Either<Failure, dynamic>> execute(LockUnlockMicParams params) async {
    return await _roomRepository.lockMic(params);
  }
}
