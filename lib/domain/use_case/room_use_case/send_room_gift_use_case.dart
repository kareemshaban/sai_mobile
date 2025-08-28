import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/send_gift_params.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class SendRoomGiftUseCase extends BaseUseCase<SendGiftParams, dynamic> {
  final RoomRepository _roomRepository;
  SendRoomGiftUseCase(this._roomRepository);

  @override
  Future<Either<Failure, dynamic>> execute(SendGiftParams params) async {
    return await _roomRepository.sendRoomGift(params);
  }
}
