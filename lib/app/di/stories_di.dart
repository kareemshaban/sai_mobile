import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/data_source/stories_data_source/stories_remote_data_source.dart';
import 'package:new_sai/data/repository/stories_repository_impl.dart';
import 'package:new_sai/domain/repository/stories_repository.dart';
import 'package:new_sai/domain/use_case/stories_use_case/add_stories_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/comment_on_story_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/delete_story_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_story_by_id_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_story_comment_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_story_views_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_user_stories_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/show_story_use_case.dart';

initStoriesModule() {
  instance.registerLazySingleton<StoriesRemoteDataSource>(
      () => StoriesremoteDataSourceImpl(instance()));

  instance.registerLazySingleton<StoriesRepository>(() => StoriesRepositoryImpl(
      networkInfo: instance(), remoteDataSource: instance()));

  instance.registerLazySingleton<AddStoriesUseCase>(
      () => AddStoriesUseCase(instance()));

  instance.registerLazySingleton<GetUserStoriesUseCase>(
      () => GetUserStoriesUseCase(instance()));

  instance.registerLazySingleton<GetStoryCommentUseCase>(
      () => GetStoryCommentUseCase(instance()));

  instance.registerLazySingleton<GetStoryViewsUseCase>(
      () => GetStoryViewsUseCase(instance()));

  instance.registerLazySingleton<CommentOnStoryUseCase>(
      () => CommentOnStoryUseCase(instance()));

  instance.registerLazySingleton<ShowStoryUseCase>(
      () => ShowStoryUseCase(instance()));

  instance.registerLazySingleton<GetStoryByIdUseCase>(
      () => GetStoryByIdUseCase(instance()));

  instance.registerLazySingleton<DeleteStoryUseCase>(
      () => DeleteStoryUseCase(instance()));
}
