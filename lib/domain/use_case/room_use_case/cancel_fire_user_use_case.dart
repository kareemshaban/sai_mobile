import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/fire_user_params.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class CancelFireUserUseCase extends BaseUseCase<FireUserParams, dynamic> {
  final RoomRepository _roomRepository;
  CancelFireUserUseCase(this._roomRepository);

  @override
  Future<Either<Failure, dynamic>> execute(FireUserParams params) async {
    return await _roomRepository.cancelFireUser(params);
  }
}
