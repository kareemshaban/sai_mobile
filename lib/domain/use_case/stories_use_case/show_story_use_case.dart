import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/stories_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class ShowStoryUseCase extends BaseUseCase<int, dynamic> {
  final StoriesRepository _storiesRepository;
  ShowStoryUseCase(this._storiesRepository);

  @override
  Future<Either<Failure, dynamic>> execute(int params) async {
    return await _storiesRepository.showStory(params);
  }
}
