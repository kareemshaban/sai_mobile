import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/domain/repository/app_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetCountryListUseCase extends BaseUseCase<dynamic, List<CountryEntity>> {
  final AppRepository _appRepository;
  GetCountryListUseCase(this._appRepository);

  @override
  Future<Either<Failure, List<CountryEntity>>> execute(dynamic params) async {
    return await _appRepository.getCountryList();
  }
}
