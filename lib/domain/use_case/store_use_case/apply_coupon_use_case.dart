import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/store_entity/coupon_entity.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class ApplyCouponUseCase extends BaseUseCase<String, CouponEntity> {
  final StoreRepository _storeRepository;
  ApplyCouponUseCase(this._storeRepository);

  @override
  Future<Either<Failure, CouponEntity>> execute(String params) async {
    return await _storeRepository.applyCoupon(params);
  }
}
