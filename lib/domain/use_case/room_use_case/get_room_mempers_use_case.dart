import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetRoomMempersUseCase extends BaseUseCase<dynamic, UserPaginationEntity> {
  final RoomRepository _roomRepository;
  GetRoomMempersUseCase(this._roomRepository);

  @override
  Future<Either<Failure, UserPaginationEntity>> execute(dynamic params) async {
    return await _roomRepository.getRoomMempers(params);
  }
}
