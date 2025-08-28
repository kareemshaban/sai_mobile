import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_sai/data/data_source/store_data_source/store_remote_data_source.dart';
import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/network/error_handler.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/network/network_info.dart';
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
import 'package:new_sai/domain/repository/store_repository.dart';

class StoreRepositoryImpl extends StoreRepository {
  final NetworkInfo _networkInfo;
  final StoreRemoteDataSource _remoteDataSource;

  StoreRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, HomeEntity>> getHomeData() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getHomeData();
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> getMyAddresses() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getMyAddresses();
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data?.map((e) => e.toDomain()).toList() ?? []);
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> addRemoveProductToFavorite(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.addRemoveProductToFavorite(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ProductPaginationEntity>> getMyFavorite(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getMyFavorite(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> addAddress(
      AddressParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.addAddress(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> updateAddress(
      AddressParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updateAddress(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteAddress(int id) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.deleteAddress(id);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, OrderPaginationEntity>> getOrders(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getOrders(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getProductDetails(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, CouponEntity>> applyCoupon(String params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.applyCoupon(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> addOrder(AddOrderParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.addOrder(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ProductPaginationEntity>> searchProduct(
      ProductSearchParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.searchAndFilterProduct(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ProductFilterEntity>> getProductFilter() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getProductFilter();
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, AddressCostEntity>> getDeliveryPrice(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getDeliveryPrice(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, OrderDetailsEntity>> getOrderDetails(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getOrderDetails(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> cancelOrder(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.cancelOrder(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
