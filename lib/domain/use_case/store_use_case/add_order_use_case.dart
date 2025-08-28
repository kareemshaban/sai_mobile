import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/store_params/add_order_params.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class AddOrderUseCase extends BaseUseCase<AddOrderParams, dynamic> {
  final StoreRepository _storeRepository;
  AddOrderUseCase(this._storeRepository);

  @override
  Future<Either<Failure, dynamic>> execute(AddOrderParams params) async {
    return await _storeRepository.addOrder(params);
  }
}
