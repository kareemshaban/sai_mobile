import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/store_entity/order_pagination_entity.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetOrdersUseCase extends BaseUseCase<int, OrderPaginationEntity> {
  final StoreRepository _storeRepository;
  GetOrdersUseCase(this._storeRepository);

  @override
  Future<Either<Failure, OrderPaginationEntity>> execute(int params) async {
    return await _storeRepository.getOrders(params);
  }
}
