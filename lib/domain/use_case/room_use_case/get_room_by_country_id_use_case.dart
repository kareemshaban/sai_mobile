import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/room_entity/room_pagination_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetRoomByCountryIdUseCase
    extends BaseUseCase<dynamic, RoomPaginationEntity> {
  final RoomRepository _roomRepository;
  GetRoomByCountryIdUseCase(this._roomRepository);

  @override
  Future<Either<Failure, RoomPaginationEntity>> execute(dynamic params) async {
    return await _roomRepository.getRoomByCountryId(params);
  }
}
