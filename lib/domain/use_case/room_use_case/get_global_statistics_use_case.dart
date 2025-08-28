import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/global_statistics_params.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetGlobalStatisticsUseCase
    extends BaseUseCase<GlobalStatisticsParams, List<UserEntity>> {
  final RoomRepository _roomRepository;
  GetGlobalStatisticsUseCase(this._roomRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> execute(
      GlobalStatisticsParams params) async {
    return await _roomRepository.getGlobalStatistics(params);
  }
}
