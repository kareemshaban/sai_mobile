import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/reels_params/reels_comment_params.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/domain/repository/reels_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class ReelsAddCommentUseCase
    extends BaseUseCase<ReelsCommentParams, ReelsCommentEntity> {
  final ReelsRepository _reelsRepository;
  ReelsAddCommentUseCase(this._reelsRepository);

  @override
  Future<Either<Failure, ReelsCommentEntity>> execute(
      ReelsCommentParams params) async {
    return await _reelsRepository.reelsAddComment(params);
  }
}
