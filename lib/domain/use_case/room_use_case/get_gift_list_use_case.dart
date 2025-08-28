import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/room_entity/gift_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetGiftListUseCase extends BaseUseCase<dynamic, List<GiftEntity>> {
  final RoomRepository _roomRepository;
  GetGiftListUseCase(this._roomRepository);

  @override
  Future<Either<Failure, List<GiftEntity>>> execute(params) async {
    return await _roomRepository.getGiftList();
  }
}
