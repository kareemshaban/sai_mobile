import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/send_message_params.dart';
import 'package:new_sai/domain/entity/room_entity/room_message_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class SendRoomMessageUseCase
    extends BaseUseCase<SendRoomMessageParams, RoomMessageEntity> {
  final RoomRepository _roomRepository;
  SendRoomMessageUseCase(this._roomRepository);

  @override
  Future<Either<Failure, RoomMessageEntity>> execute(
      SendRoomMessageParams params) async {
    return await _roomRepository.sendRoomMessage(params);
  }
}
