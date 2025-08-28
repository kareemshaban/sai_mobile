import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/store_entity/address_entity.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetMyAddressesUseCase extends BaseUseCase<dynamic, List<AddressEntity>> {
  final StoreRepository _storeRepository;
  GetMyAddressesUseCase(this._storeRepository);

  @override
  Future<Either<Failure, List<AddressEntity>>> execute(params) async {
    return await _storeRepository.getMyAddresses();
  }
}
