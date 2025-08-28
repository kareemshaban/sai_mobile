import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/domain/repository/reels_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class ShowReelsUseCase extends BaseUseCase<int, ReelsEntity> {
  final ReelsRepository _reelsRepository;
  ShowReelsUseCase(this._reelsRepository);

  @override
  Future<Either<Failure, ReelsEntity>> execute(int params) async {
    return await _reelsRepository.showReels(params);
  }
}
