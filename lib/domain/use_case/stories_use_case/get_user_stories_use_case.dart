import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';
import 'package:new_sai/domain/repository/stories_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetUserStoriesUseCase
    extends BaseUseCase<dynamic, StoryPaginationEntity> {
  final StoriesRepository _storiesRepository;
  GetUserStoriesUseCase(this._storiesRepository);

  @override
  Future<Either<Failure, StoryPaginationEntity>> execute(dynamic params) async {
    return await _storiesRepository.getUserStories(params);
  }
}
