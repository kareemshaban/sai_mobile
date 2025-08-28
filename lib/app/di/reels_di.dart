import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/data_source/reels_data_source/reels_remote_data_source.dart';
import 'package:new_sai/data/repository/reels_repository_impl.dart';
import 'package:new_sai/domain/repository/reels_repository.dart';
import 'package:new_sai/domain/use_case/reels_use_case/add_reels_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/delete_reels_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/get_reels_comment_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/get_reels_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/get_saved_reels_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/get_user_reels_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/like_reel_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/reels_add_comment_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/save_reel_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/share_reel_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/show_reels_use_case.dart';

initReelsModule() {
  instance.registerLazySingleton<ReelsRemoteDataSource>(
      () => ReelsRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<ReelsRepository>(
      () => ReelsRepositoryImpl(instance(), instance()));

  instance.registerLazySingleton<GetReelsUseCase>(
      () => GetReelsUseCase(instance()));

  instance.registerLazySingleton<GetReelsCommentUseCase>(
      () => GetReelsCommentUseCase(instance()));

  instance.registerLazySingleton<ReelsAddCommentUseCase>(
      () => ReelsAddCommentUseCase(instance()));

  instance.registerLazySingleton<LikeReelUseCase>(
      () => LikeReelUseCase(instance()));

  instance.registerLazySingleton<SaveReelUseCase>(
      () => SaveReelUseCase(instance()));

  instance.registerLazySingleton<GetSavedReelsUseCase>(
      () => GetSavedReelsUseCase(instance()));

  instance.registerLazySingleton<GetUserReelsUseCase>(
      () => GetUserReelsUseCase(instance()));

  instance.registerLazySingleton<AddReelsUseCase>(
      () => AddReelsUseCase(instance()));

  instance.registerLazySingleton<ShowReelsUseCase>(
      () => ShowReelsUseCase(instance()));

  instance.registerLazySingleton<DeleteReelsUseCase>(
      () => DeleteReelsUseCase(instance()));

  instance.registerLazySingleton<ShareReelUseCase>(
      () => ShareReelUseCase(instance()));
}
