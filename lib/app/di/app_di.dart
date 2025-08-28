import 'package:new_sai/data/data_source/app_data_source/app_remote_data_source.dart';
import 'package:new_sai/data/repository/app_repository_impl.dart';
import 'package:new_sai/domain/repository/app_repository.dart';
import 'package:new_sai/domain/use_case/app_use_case/get_app_info_use_case.dart';
import 'package:new_sai/domain/use_case/app_use_case/get_app_search_use_case.dart';
import 'package:new_sai/domain/use_case/app_use_case/get_country_list_use_case.dart';

import 'basic_di.dart';

initAppModule() {
  instance.registerLazySingleton<AppRemoteDataSource>(
      () => AppRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
        instance(),
        instance(),
      ));

  instance.registerLazySingleton<GetCountryListUseCase>(
      () => GetCountryListUseCase(instance()));

  instance.registerLazySingleton<GetAppInfoUseCase>(
      () => GetAppInfoUseCase(instance()));

  instance.registerLazySingleton<GetAppSearchUseCase>(
      () => GetAppSearchUseCase(instance()));
}
