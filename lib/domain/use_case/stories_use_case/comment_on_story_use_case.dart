import 'package:dartz/dartz.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/reels_params/reels_comment_params.dart';
import 'package:new_sai/domain/repository/stories_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class CommentOnStoryUseCase
    extends BaseUseCase<ReelsCommentParams, BaseMapModel> {
  final StoriesRepository _storiesRepository;
  CommentOnStoryUseCase(this._storiesRepository);

  @override
  Future<Either<Failure, BaseMapModel>> execute(
      ReelsCommentParams params) async {
    return await _storiesRepository.commentOnStory(params);
  }
}
