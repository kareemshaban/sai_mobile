import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/model/store_model/address_cost_model.dart';
import 'package:new_sai/data/model/store_model/address_model.dart';
import 'package:new_sai/data/model/store_model/coupon_model.dart';
import 'package:new_sai/data/model/store_model/home_model.dart';
import 'package:new_sai/data/model/store_model/order_details_model.dart';
import 'package:new_sai/data/model/store_model/order_pagination_model.dart';
import 'package:new_sai/data/model/store_model/product_filter_model.dart';
import 'package:new_sai/data/model/store_model/product_model.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/end_point.dart';
import 'package:new_sai/data/params/store_params/add_order_params.dart';
import 'package:new_sai/data/params/store_params/address_params.dart';
import 'package:new_sai/data/params/store_params/product_search_params.dart';

abstract class StoreRemoteDataSource {
  Future<BaseMapModel<HomeModel>> getHomeData();
  Future<BaseListModel<AddressModel>> getMyAddresses();
  Future<BaseMapModel> addRemoveProductToFavorite(int params);
  Future<BaseMapModel<ProductPaginationModel>> getMyFavorite(int params);
  Future<BaseMapModel<AddressModel>> addAddress(AddressParams params);
  Future<BaseMapModel<AddressModel>> updateAddress(AddressParams params);
  Future<BaseMapModel> deleteAddress(int id);
  Future<BaseMapModel<OrderPaginationModel>> getOrders(int params);
  Future<BaseMapModel<ProductDetailsModel>> getProductDetails(int params);
  Future<BaseMapModel<CouponModel>> applyCoupon(String params);
  Future<BaseMapModel> addOrder(AddOrderParams params);
  Future<BaseMapModel<ProductPaginationModel>> searchAndFilterProduct(
      ProductSearchParams params);
  Future<BaseMapModel<ProductFilterModel>> getProductFilter();
  Future<BaseMapModel<AddressCostModel>> getDeliveryPrice(int params);
  Future<BaseMapModel<OrderDetailsModel>> getOrderDetails(int params);
  Future<BaseMapModel> cancelOrder(int params);
}

class StoreRemoteDataSourceImpl extends StoreRemoteDataSource {
  final AppServiceClient _appServiceClient;

  StoreRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseMapModel<HomeModel>> getHomeData() async {
    return await _appServiceClient.performGetRequest(
      EndPoint.home,
      HomeModel.fromJson,
    );
  }

  @override
  Future<BaseListModel<AddressModel>> getMyAddresses() async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.myAddresses,
      AddressModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> addRemoveProductToFavorite(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.addRemoveProductToFavorite(params),
      (p0) => null,
    );
  }

  @override
  Future<BaseMapModel<ProductPaginationModel>> getMyFavorite(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.getMyFavorite,
      ProductPaginationModel.fromJson,
      params: {
        "page": params,
      },
    );
  }

  @override
  Future<BaseMapModel<AddressModel>> addAddress(AddressParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.addAddress,
      params.toJson(),
      AddressModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<AddressModel>> updateAddress(AddressParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.updateAddress(params.id ?? 0),
      params.toJson(),
      AddressModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> deleteAddress(int id) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.deleteAddress(id),
      (p0) => null,
    );
  }

  @override
  Future<BaseMapModel<OrderPaginationModel>> getOrders(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.orders,
      OrderPaginationModel.fromJson,
      params: {
        'page': params,
      },
    );
  }

  @override
  Future<BaseMapModel<ProductDetailsModel>> getProductDetails(
      int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.getProductDetails(params),
      ProductDetailsModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<CouponModel>> applyCoupon(String params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.applyCoupon,
      {
        'code': params,
      },
      CouponModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> addOrder(AddOrderParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.addOrder,
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<ProductPaginationModel>> searchAndFilterProduct(
      ProductSearchParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.searchProduct(params.page!),
      params.toJson(),
      ProductPaginationModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<ProductFilterModel>> getProductFilter() async {
    return await _appServiceClient.performGetRequest(
      EndPoint.productFilter,
      ProductFilterModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<AddressCostModel>> getDeliveryPrice(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.getDeliveryPrice(params),
      AddressCostModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<OrderDetailsModel>> getOrderDetails(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.getOrderDetails(params),
      OrderDetailsModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> cancelOrder(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.cancelOrder(params),
      (value) => null,
    );
  }
}
