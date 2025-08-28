import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/store_params/product_search_params.dart';
import 'package:new_sai/domain/entity/store_entity/product_entity.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class SearchProductUseCase
    extends BaseUseCase<ProductSearchParams, ProductPaginationEntity> {
  final StoreRepository _storeRepository;
  SearchProductUseCase(this._storeRepository);

  @override
  Future<Either<Failure, ProductPaginationEntity>> execute(
      ProductSearchParams params) async {
    return await _storeRepository.searchProduct(params);
  }
}
