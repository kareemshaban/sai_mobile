import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/domain/repository/reels_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetReelsCommentUseCase
    extends BaseUseCase<dynamic, ReelsCommentPaginationEntity> {
  final ReelsRepository _reelsRepository;
  GetReelsCommentUseCase(this._reelsRepository);

  @override
  Future<Either<Failure, ReelsCommentPaginationEntity>> execute(
      dynamic params) async {
    return await _reelsRepository.getReelsComment(params);
  }
}
