import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/store_entity/home_entity.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetHomeDataUseCase extends BaseUseCase<dynamic, HomeEntity> {
  final StoreRepository _storeRepository;
  GetHomeDataUseCase(this._storeRepository);

  @override
  Future<Either<Failure, HomeEntity>> execute(dynamic params) async {
    return await _storeRepository.getHomeData();
  }
}
