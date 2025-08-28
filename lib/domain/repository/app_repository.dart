import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/app_params/app_search_params.dart';
import 'package:new_sai/domain/entity/app_entity/app_info_entity.dart';
import 'package:new_sai/domain/entity/app_entity/app_search_entity.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';

abstract class AppRepository {
  Future<Either<Failure, List<CountryEntity>>> getCountryList();
  Future<Either<Failure, AppInfoEntity>> getAppInfo();
  Future<Either<Failure, AppSearchEntity>> getAppSearch(AppSearchParams params);
}
