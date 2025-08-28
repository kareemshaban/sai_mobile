import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/app_entity/app_info_entity.dart';
import 'package:new_sai/domain/repository/app_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetAppInfoUseCase extends BaseUseCase<dynamic, AppInfoEntity> {
  final AppRepository _appRepository;
  GetAppInfoUseCase(this._appRepository);

  @override
  Future<Either<Failure, AppInfoEntity>> execute(params) async {
    return await _appRepository.getAppInfo();
  }
}
