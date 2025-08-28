import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/enums.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/country_model.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/store_model/address_cost_model.dart';
import 'package:new_sai/data/model/store_model/address_model.dart';
import 'package:new_sai/data/model/store_model/banner_model.dart';
import 'package:new_sai/data/model/store_model/category_model.dart';
import 'package:new_sai/data/model/store_model/coupon_model.dart';
import 'package:new_sai/data/model/store_model/home_model.dart';
import 'package:new_sai/data/model/store_model/market_model.dart';
import 'package:new_sai/data/model/store_model/order_details_model.dart';
import 'package:new_sai/data/model/store_model/order_model.dart';
import 'package:new_sai/data/model/store_model/order_pagination_model.dart';
import 'package:new_sai/data/model/store_model/product_filter_model.dart';
import 'package:new_sai/data/model/store_model/product_model.dart';
import 'package:new_sai/data/model/store_model/product_option_model.dart';
import 'package:new_sai/data/model/store_model/product_quantity_options_model.dart';
import 'package:new_sai/domain/entity/store_entity/address_cost_entity.dart';
import 'package:new_sai/domain/entity/store_entity/address_entity.dart';
import 'package:new_sai/domain/entity/store_entity/banner_entity.dart';
import 'package:new_sai/domain/entity/store_entity/category_entity.dart';
import 'package:new_sai/domain/entity/store_entity/coupon_entity.dart';
import 'package:new_sai/domain/entity/store_entity/home_entity.dart';
import 'package:new_sai/domain/entity/store_entity/market_entity.dart';
import 'package:new_sai/domain/entity/store_entity/order_details_entity.dart';
import 'package:new_sai/domain/entity/store_entity/order_entity.dart';
import 'package:new_sai/domain/entity/store_entity/order_pagination_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_filter_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_option_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_quantity_options_entity.dart';

extension HomeMapper on HomeModel? {
  HomeEntity toDomain() {
    return HomeEntity(
      categories: this?.categories != null
          ? this!.categories!.map((e) => e.toDomain()).toList()
          : [],
      products: this?.products != null
          ? this!.products!.map((e) => e.toDomain()).toList()
          : [],
      banners: this?.banners != null
          ? this!.banners!.map((e) => e.toDomain()).toList()
          : [],
    );
  }
}

extension ProductPaginationMapper on ProductPaginationModel? {
  ProductPaginationEntity toDomain() {
    return ProductPaginationEntity(
      data: this?.data != null
          ? this!.data!.map((e) => e.toDomain()).toList()
          : [],
      pagination: this?.pagination != null
          ? this!.pagination.toDomain()
          : PaginationModel().toDomain(),
    );
  }
}

extension ProductDetailsMapper on ProductDetailsModel? {
  ProductDetailsEntity toDomain() {
    return ProductDetailsEntity(
      product: this?.product?.toDomain() ?? ProductModel().toDomain(),
      relatedProducts:
          this?.relatedProducts?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension ProductMapper on ProductModel? {
  ProductEntity toDomain() {
    return ProductEntity(
      name: this?.name ?? Constants.empty,
      id: this?.id ?? Constants.zero,
      image: this?.image ?? Constants.empty,
      buyPrice: this?.buyPrice ?? Constants.zero,
      category: this?.category?.toDomain() ?? CategoryModel().toDomain(),
      hasOptions: this?.hasOptions ?? Constants.zero,
      isMyFavorite: this?.isMyFavorite ?? Constants.zero,
      isRateByMe: this?.isRateByMe ?? Constants.zero,
      offerPrice: this?.offerPrice ?? Constants.zero,
      reviewVal: this?.reviewVal ?? Constants.zero,
      reviewsCount: this?.reviewsCount ?? Constants.zero,
      code: this?.code ?? Constants.empty,
      market: this?.market?.toDomain() ?? MarketModel().toDomain(),
      countView: this?.countView ?? Constants.zero,
      description: this?.description ?? Constants.empty,
      images: this?.images?.map((e) => e.toDomain()).toList() ?? [],
      maxOrderQnt: this?.maxOrderQnt ?? Constants.zero,
      minOrderQnt: this?.minOrderQnt ?? Constants.zero,
      options: this?.options?.map((e) => e.toDomain()).toList() ?? [],
      quantity: this?.quantity ?? Constants.zero,
      quantityOptions:
          this?.quantityOptions?.map((e) => e.toDomain()).toList() ?? [],
      price: this?.price ?? Constants.zero,
    );
  }
}

extension CategoryMapper on CategoryModel? {
  CategoryEntity toDomain() {
    return CategoryEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      image: this?.image ?? Constants.empty,
    );
  }
}

extension AddressMapper on AddressModel? {
  AddressEntity toDomain() {
    return AddressEntity(
      id: this?.id ?? Constants.zero,
      country: this?.country != null
          ? this!.country.toDomain()
          : CountryModel().toDomain(),
      street: this?.street ?? Constants.empty,
      phone: this?.phone ?? Constants.empty,
      fullName: this?.fullName ?? Constants.empty,
      isDefault: this?.isDefault == 1,
      optionalPhone: this?.optionalPhone ?? Constants.empty,
      streetMark: this?.streetMark ?? Constants.empty,
    );
  }
}

extension BannerMapper on BannerModel? {
  BannerEntity toDomain() {
    return BannerEntity(
      image: this?.image ?? Constants.empty,
      type: this?.type ?? Constants.empty,
      typeVal: this?.typeVal ?? Constants.empty,
    );
  }
}

extension OrderPaginationMapper on OrderPaginationModel? {
  OrderPaginationEntity toDomain() {
    return OrderPaginationEntity(
      pagination: this?.pagination != null
          ? this!.pagination.toDomain()
          : PaginationModel().toDomain(),
      data: this?.data != null
          ? this!.data!.map((e) => e.toDomain()).toList()
          : [],
    );
  }
}

extension OrderMapper on OrderModel? {
  OrderEntity toDomain() {
    return OrderEntity(
      id: this?.id ?? Constants.zero,
      market: this?.market != null
          ? this!.market.toDomain()
          : MarketModel().toDomain(),
      orderDatetime: this?.orderDatetime ?? Constants.empty,
      productCount: this?.productCount ?? Constants.zero,
      statue: (this?.statue ?? Constants.empty).toOrderState(),
      statueTranslate: this?.statueTranslate ?? Constants.empty,
    );
  }
}

extension MarketMapper on MarketModel? {
  MarketEntity toDomain() {
    return MarketEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      logo: this?.logo ?? Constants.empty,
    );
  }
}

extension ProductOptionMapper on ProductOptionModel? {
  ProductOptionEntity toDomain() {
    return ProductOptionEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      type: this?.type ?? Constants.empty,
      price: this?.price ?? Constants.zero,
      values: this?.values?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension ProductOptionValuesMapper on ProductOptionValuesModel? {
  ProductOptionValuesEntity toDomain() {
    return ProductOptionValuesEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
    );
  }
}

extension ProductQuantityOptionMapper on ProductQuantityOptionsModel? {
  ProductQuantityOptionEntity toDomain() {
    return ProductQuantityOptionEntity(
      quantityOptionId: this?.quantityOptionId ?? Constants.zero,
      optionValueId:
          this?.optionValueId?.map((e) => e.toDomain()).toList() ?? [],
      qnt: this?.qnt ?? Constants.zero,
      buyPrice: this?.buyPrice ?? Constants.zero,
      minOrderQnt: this?.minOrderQnt ?? Constants.zero,
      maxOrderQnt: this?.maxOrderQnt ?? Constants.zero,
    );
  }
}

extension ProductQuantityOptionValueMapper
    on ProductQuantityOptionValuesModel? {
  ProductQuantityOptionValueEntity toDomain() {
    return ProductQuantityOptionValueEntity(
      option: this?.option ?? Constants.zero,
      value: this?.value ?? Constants.zero,
    );
  }
}

extension ProductFilterMapper on ProductFilterModel? {
  ProductFilterEntity toDomain() {
    return ProductFilterEntity(
      options: this?.options?.map((e) => e.toDomain()).toList() ?? [],
      categories: this?.categories?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension CouponMapper on CouponModel? {
  CouponEntity toDomain() {
    return CouponEntity(
      discount: this?.discount ?? Constants.zero,
      discountId: this?.discountId ?? Constants.zero,
    );
  }
}

extension AddressCostMapper on AddressCostModel? {
  AddressCostEntity toDomain() {
    return AddressCostEntity(
      cost: this?.cost ?? Constants.zero,
    );
  }
}

extension OrderDetailsMapper on OrderDetailsModel? {
  OrderDetailsEntity toDomain() {
    return OrderDetailsEntity(
      id: this?.id ?? Constants.zero,
      products: this?.products?.map((e) => e.toDomain()).toList() ?? [],
      deliveryType: this?.deliveryType ?? Constants.empty,
      market: this?.market?.toDomain() ?? MarketModel().toDomain(),
      deliveryCost: this?.deliveryCost ?? Constants.zero,
      deliveryTypeTranslate: this?.deliveryTypeTranslate ?? Constants.empty,
      discountCost: this?.discountCost ?? Constants.zero,
      discountPercent: this?.discountPercent ?? Constants.zero,
      orderDatetime: this?.orderDatetime ?? Constants.empty,
      partCost: this?.partCost ?? Constants.zero,
      productCount: this?.productCount ?? Constants.zero,
      statue: this?.statue ?? Constants.empty,
      statueTranslate: this?.statueTranslate ?? Constants.empty,
      totalCost: this?.totalCost ?? Constants.zero,
      address: this?.address?.toDomain() ?? AddressModel().toDomain(),
    );
  }
}
