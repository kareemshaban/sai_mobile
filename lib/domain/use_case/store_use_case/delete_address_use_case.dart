import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class DeleteAddressUseCase extends BaseUseCase<int, dynamic> {
  final StoreRepository _storeRepository;
  DeleteAddressUseCase(this._storeRepository);

  @override
  Future<Either<Failure, dynamic>> execute(int params) async {
    return await _storeRepository.deleteAddress(params);
  }
}
