import 'package:dartz/dartz.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/reels_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class ShareReelUseCase extends BaseUseCase<int, BaseMapModel> {
  final ReelsRepository _repository;
  ShareReelUseCase(this._repository);

  @override
  Future<Either<Failure, BaseMapModel>> execute(int params) async {
    return await _repository.shareReels(params);
  }
}
