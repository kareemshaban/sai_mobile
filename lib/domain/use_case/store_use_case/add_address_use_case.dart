import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/store_params/address_params.dart';
import 'package:new_sai/domain/entity/store_entity/address_entity.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class AddAddressUseCase extends BaseUseCase<AddressParams, AddressEntity> {
  final StoreRepository _storeRepository;
  AddAddressUseCase(this._storeRepository);

  @override
  Future<Either<Failure, AddressEntity>> execute(AddressParams params) async {
    return await _storeRepository.addAddress(params);
  }
}
