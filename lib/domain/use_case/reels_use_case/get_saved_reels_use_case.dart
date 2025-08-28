import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/domain/repository/reels_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetSavedReelsUseCase extends BaseUseCase<int, ReelsPaginationEntity> {
  final ReelsRepository _reelsRepository;
  GetSavedReelsUseCase(this._reelsRepository);

  @override
  Future<Either<Failure, ReelsPaginationEntity>> execute(int params) async {
    return await _reelsRepository.getSavedReels(params);
  }
}
