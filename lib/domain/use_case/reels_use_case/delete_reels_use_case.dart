import 'package:dartz/dartz.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/reels_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class DeleteReelsUseCase extends BaseUseCase<int, BaseMapModel> {
  final ReelsRepository _reelsRepository;
  DeleteReelsUseCase(this._reelsRepository);

  @override
  Future<Either<Failure, BaseMapModel>> execute(int params) async {
    return await _reelsRepository.deleteReels(params);
  }
}
