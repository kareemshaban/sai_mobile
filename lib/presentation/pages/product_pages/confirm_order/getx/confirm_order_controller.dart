import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/model/store_model/coupon_model.dart';
import 'package:new_sai/data/params/store_params/add_order_params.dart';
import 'package:new_sai/domain/entity/store_entity/coupon_entity.dart';
import 'package:new_sai/domain/use_case/store_use_case/add_order_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/apply_coupon_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_delivery_price_use_case.dart';
import 'package:new_sai/presentation/pages/address_pages/address/getx/address_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/getx/cart_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ConfirmOrderController extends GetxController {
  final cartController = Get.find<CartController>();
  final addressController = Get.find<AddressController>();
  final appController = Get.find<AppController>();
  final noteController = TextEditingController();
  final couponController = TextEditingController();
  final ApplyCouponUseCase _applyCouponUseCase = instance<ApplyCouponUseCase>();
  final AddOrderUseCase _addOrderUseCase = instance<AddOrderUseCase>();
  final GetDeliveryPriceUseCase _deliveryPriceUseCase =
      instance<GetDeliveryPriceUseCase>();

  final RxString _deliveryValue = "".obs;
  final RxBool _loadingCoupon = false.obs;
  final RxBool _loadingAddOrder = false.obs;
  final Rx<CouponEntity> _coupon = CouponModel().toDomain().obs;
  final Rx<num> _addressCost = 0.obs;

  String get deliveryValue => _deliveryValue.value;
  bool get loadingCoupon => _loadingCoupon.value;
  bool get loadingAddOrder => _loadingAddOrder.value;
  CouponEntity get coupon => _coupon.value;
  num get addressCost => _addressCost.value;

  set deliveryValue(value) => _deliveryValue.value = value;
  set loadingCoupon(value) => _loadingCoupon.value = value;
  set loadingAddOrder(value) => _loadingAddOrder.value = value;
  set coupon(CouponEntity value) => _coupon.value = value;
  set addressCost(value) => _addressCost.value = value;

  onChangeDeliveryValue(value) {
    deliveryValue = value;
    if (value == 'to_address') {
      getDeliveryPrice();
    } else {
      addressCost = 0;
    }
  }

  applyCoupon() async {
    if (coupon.discountId != 0) {
      coupon = CouponModel().toDomain();
      couponController.clear();
      return;
    }
    if (couponController.text.isEmpty) {
      return;
    }
    if (loadingCoupon) return;
    loadingCoupon = true;
    (await _applyCouponUseCase.execute(couponController.text)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        coupon = r;
      },
    );
    loadingCoupon = false;
  }

  num getProductPrice() {
    return cartController.getAllProductPrice();
  }

  addOrder() async {
    if (cartController.getAllProductPrice() > appController.user.goldValue) {
      showSnackBarWidget(message: AppStrings.thereIsNotEnoughBalance);
      return;
    }
    if (deliveryValue.isEmpty) {
      showSnackBarWidget(message: AppStrings.pleaseSelectDeliveryMethod);
      return;
    }
    if (loadingAddOrder) return;
    loadingAddOrder = true;
    final list = <AddOrderProductParams>[];
    for (var e in cartController.products) {
      list.add(
        AddOrderProductParams(
          totalPrice: e.quantity * e.price,
          quantityOptionId: e.quantityOptionId ?? 0,
          optionCheck: e.optionalOption ?? [],
          productId: e.id,
          quantity: e.quantity,
        ),
      );
    }
    final params = AddOrderParams(
      deliveryType: deliveryValue,
      addressId: deliveryValue == "to_address"
          ? addressController.selectedAddress.id
          : null,
      partPrice: getProductPrice(),
      totalPrice: getFinalPrice(),
      note: noteController.text.isEmpty ? null : noteController.text,
      products: list,
      discountId: coupon.discountId != 0 ? coupon.discountId : null,
    );
    (await _addOrderUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        cartController.deleteCard();
        Get.until((route) {
          if (Get.currentRoute == AppRoutes.mainRoute) {
            return true;
          }
          return false;
        });
      },
    );
    loadingAddOrder = false;
  }

  getDeliveryPrice() async {
    if (addressController.selectedAddress.id != 0) {
      showAppLoadingDialog(barrierDismissible: true);
      (await _deliveryPriceUseCase
              .execute(addressController.selectedAddress.id))
          .fold(
        (l) {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          showSnackBarWidget(message: l.message);
        },
        (r) {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          addressCost = r.cost;
        },
      );
    }
  }

  num getFinalPrice() {
    return getProductPrice() -
        ((getProductPrice() * coupon.discount) / 100) +
        addressCost;
  }
}
