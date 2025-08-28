import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/store_entity/order_details_entity.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetOrderDetailsUseCase extends BaseUseCase<int, OrderDetailsEntity> {
  final StoreRepository _storeRepository;
  GetOrderDetailsUseCase(this._storeRepository);

  @override
  Future<Either<Failure, OrderDetailsEntity>> execute(int params) async {
    return await _storeRepository.getOrderDetails(params);
  }
}
