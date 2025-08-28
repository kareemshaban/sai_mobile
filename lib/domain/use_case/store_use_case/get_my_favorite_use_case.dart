import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/store_entity/product_entity.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetMyFavoriteUseCase extends BaseUseCase<int, ProductPaginationEntity> {
  final StoreRepository _storeRepository;
  GetMyFavoriteUseCase(this._storeRepository);

  @override
  Future<Either<Failure, ProductPaginationEntity>> execute(int params) async {
    return await _storeRepository.getMyFavorite(params);
  }
}
