import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/room_entity/room_gift_users_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetRoomGiftUsersUseCase
    extends BaseUseCase<Map<String, dynamic>, RoomGiftUsersEntityPagination> {
  final RoomRepository _repository;
  GetRoomGiftUsersUseCase(this._repository);

  @override
  Future<Either<Failure, RoomGiftUsersEntityPagination>> execute(
      Map<String, dynamic> params) async {
    return await _repository.getRoomGiftUsers(params);
  }
}
