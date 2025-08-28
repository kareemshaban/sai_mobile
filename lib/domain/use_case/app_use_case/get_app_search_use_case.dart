import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/app_params/app_search_params.dart';
import 'package:new_sai/domain/entity/app_entity/app_search_entity.dart';
import 'package:new_sai/domain/repository/app_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetAppSearchUseCase
    extends BaseUseCase<AppSearchParams, AppSearchEntity> {
  final AppRepository _appRepository;
  GetAppSearchUseCase(this._appRepository);

  @override
  Future<Either<Failure, AppSearchEntity>> execute(
      AppSearchParams params) async {
    return await _appRepository.getAppSearch(params);
  }
}
