import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/reels_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class LikeReelUseCase extends BaseUseCase<int, dynamic> {
  final ReelsRepository _reelsRepository;
  LikeReelUseCase(this._reelsRepository);

  @override
  Future<Either<Failure, dynamic>> execute(int params) async {
    return await _reelsRepository.likeReel(params);
  }
}
