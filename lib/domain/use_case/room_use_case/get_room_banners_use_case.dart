import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/room_entity/room_banners_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetRoomBannersUseCase extends BaseUseCase<dynamic, RoomBannersEntity> {
  final RoomRepository _roomRepository;
  GetRoomBannersUseCase(this._roomRepository);

  @override
  Future<Either<Failure, RoomBannersEntity>> execute(dynamic params) async {
    return await _roomRepository.getRoomBanners();
  }
}
