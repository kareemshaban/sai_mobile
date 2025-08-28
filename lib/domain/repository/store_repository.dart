import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/store_params/add_order_params.dart';
import 'package:new_sai/data/params/store_params/address_params.dart';
import 'package:new_sai/data/params/store_params/product_search_params.dart';
import 'package:new_sai/domain/entity/store_entity/address_cost_entity.dart';
import 'package:new_sai/domain/entity/store_entity/address_entity.dart';
import 'package:new_sai/domain/entity/store_entity/coupon_entity.dart';
import 'package:new_sai/domain/entity/store_entity/home_entity.dart';
import 'package:new_sai/domain/entity/store_entity/order_details_entity.dart';
import 'package:new_sai/domain/entity/store_entity/order_pagination_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_filter_entity.dart';

abstract class StoreRepository {
  Future<Either<Failure, HomeEntity>> getHomeData();
  Future<Either<Failure, List<AddressEntity>>> getMyAddresses();
  Future<Either<Failure, dynamic>> addRemoveProductToFavorite(int params);
  Future<Either<Failure, ProductPaginationEntity>> getMyFavorite(int params);
  Future<Either<Failure, AddressEntity>> addAddress(AddressParams params);
  Future<Either<Failure, AddressEntity>> updateAddress(AddressParams params);
  Future<Either<Failure, dynamic>> deleteAddress(int id);
  Future<Either<Failure, OrderPaginationEntity>> getOrders(int params);
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(int params);
  Future<Either<Failure, CouponEntity>> applyCoupon(String params);
  Future<Either<Failure, dynamic>> addOrder(AddOrderParams params);
  Future<Either<Failure, ProductPaginationEntity>> searchProduct(
      ProductSearchParams params);
  Future<Either<Failure, ProductFilterEntity>> getProductFilter();
  Future<Either<Failure, AddressCostEntity>> getDeliveryPrice(int params);
  Future<Either<Failure, OrderDetailsEntity>> getOrderDetails(int params);
  Future<Either<Failure, dynamic>> cancelOrder(int params);
}
