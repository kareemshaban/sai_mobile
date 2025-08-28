import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetUsersInRoomUseCase
    extends BaseUseCase<List<String>, List<UserEntity>> {
  final RoomRepository _roomRepository;
  GetUsersInRoomUseCase(this._roomRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> execute(List<String> params) async {
    return await _roomRepository.getUsersInRoom(params);
  }
}
