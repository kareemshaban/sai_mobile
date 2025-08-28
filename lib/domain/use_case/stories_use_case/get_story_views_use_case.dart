import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/domain/repository/stories_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetStoryViewsUseCase
    extends BaseUseCase<dynamic, ReelsCommentPaginationEntity> {
  final StoriesRepository _storiesRepository;
  GetStoryViewsUseCase(this._storiesRepository);

  @override
  Future<Either<Failure, ReelsCommentPaginationEntity>> execute(
      dynamic params) async {
    return await _storiesRepository.getStoryViews(params);
  }
}
