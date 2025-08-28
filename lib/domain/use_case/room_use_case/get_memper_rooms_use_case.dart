import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/room_entity/room_pagination_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetMemperRoomsUseCase extends BaseUseCase<int, RoomPaginationEntity> {
  final RoomRepository _roomRepository;
  GetMemperRoomsUseCase(this._roomRepository);

  @override
  Future<Either<Failure, RoomPaginationEntity>> execute(int params) async {
    return await _roomRepository.getMemperRooms(params);
  }
}
