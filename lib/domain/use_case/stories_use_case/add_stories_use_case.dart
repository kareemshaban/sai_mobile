import 'package:dartz/dartz.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/story_params/add_story_params.dart';
import 'package:new_sai/domain/repository/stories_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class AddStoriesUseCase extends BaseUseCase<AddStoryParams, BaseMapModel> {
  final StoriesRepository _storiesRepository;
  AddStoriesUseCase(this._storiesRepository);

@override
  Future<Either<Failure, BaseMapModel>> execute(AddStoryParams params) async {
    return await _storiesRepository.addStory(params);
  }
}
