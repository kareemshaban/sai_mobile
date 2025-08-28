import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/generate_zego_token_params.dart';
import 'package:new_sai/domain/entity/room_entity/zego_token_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GenerateZegoTokenUseCase
    extends BaseUseCase<GenerateZegoTokenParams, ZegoTokenEntity> {
  final RoomRepository _roomRepository;
  GenerateZegoTokenUseCase(this._roomRepository);

  @override
  Future<Either<Failure, ZegoTokenEntity>> execute(
      GenerateZegoTokenParams params) async {
    return await _roomRepository.generateZegoToken(params);
  }
}
