import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/store_entity/address_cost_entity.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetDeliveryPriceUseCase extends BaseUseCase<int, AddressCostEntity> {
  final StoreRepository _storeRepository;
  GetDeliveryPriceUseCase(this._storeRepository);

  @override
  Future<Either<Failure, AddressCostEntity>> execute(int params) async {
    return await _storeRepository.getDeliveryPrice(params);
  }
}
