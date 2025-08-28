import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/settings_mapper.dart';
import 'package:new_sai/data/model/settings_model/unique_id_model.dart';
import 'package:new_sai/data/params/settings_params/get_settings_product_params.dart';
import 'package:new_sai/domain/entity/settings_entity/settings_market_product_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/unique_id_entity.dart';
import 'package:new_sai/domain/use_case/settings_use_case/buy_settings_market_product_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_settings_market_product_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/select_settings_market_product_use_case.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class UniquePersonalIdController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final appController = Get.find<AppController>();
  late TabController tabController;
  final GetSettingsMarketProductUseCase _getSettingsMarketProductUseCase =
      instance<GetSettingsMarketProductUseCase>();
  final BuySettingsMarketProductUseCase _buySettingsMarketProductUseCase =
      instance<BuySettingsMarketProductUseCase>();
  final SelectSettingsMarketProductUseCase _selectSettingsMarketProductUseCase =
      instance<SelectSettingsMarketProductUseCase>();

  final RxInt _currentIndex = 0.obs;
  final Rx<UniqueIdEntity> _market = UniqueIdModel().toDomain().obs;
  final RxBool _loadingProducts = false.obs;
  final RxList<SettingsMarketProductEntity> _products =
      <SettingsMarketProductEntity>[].obs;

  int get currentIndex => _currentIndex.value;
  UniqueIdEntity get market => _market.value;
  bool get loadingProducts => _loadingProducts.value;
  List<SettingsMarketProductEntity> get products => _products;

  set currentIndex(value) => _currentIndex.value = value;
  set market(UniqueIdEntity value) => _market.value = value;
  set loadingProducts(value) => _loadingProducts.value = value;
  set products(List<SettingsMarketProductEntity> value) =>
      _products.value = value;

  getProduct() async {
    products.clear();
    loadingProducts = true;
    final params = GetSettingsProductParams(
      catID: market.id,
      type: market.subcategories[currentIndex].id != 0 ? 1 : 0,
      pattern: market.subcategories[currentIndex].patterns.isNotEmpty
          ? market.subcategories[currentIndex].patterns.first.id
          : null,
      subcategory: market.subcategories[currentIndex].id != 0
          ? market.subcategories[currentIndex].id
          : null,
    );
    (await _getSettingsMarketProductUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        products = r;
      },
    );
    loadingProducts = false;
  }

  buyProduct(int params) async {
    Get.back();
    showAppLoadingDialog(barrierDismissible: true);
    (await _buySettingsMarketProductUseCase.execute(params)).fold(
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
        showSnackBarWidget(
          message: AppStrings.purchased,
          color: ColorManager.green,
        );
        for (var element in products) {
          if (element.id == r.id) {
            element.isBuy = r.isBuy;
          }
        }
        _products.refresh();
      },
    );
  }

  Future<bool> selectProduct(int params) async {
    if (Get.isDialogOpen == false) {
      showAppLoadingDialog(barrierDismissible: true);
    }
    return (await _selectSettingsMarketProductUseCase.execute(params)).fold(
      (l) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        showSnackBarWidget(message: l.message);
        return false;
      },
      (r) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        showSnackBarWidget(
            message: AppStrings.wasAppointed, color: ColorManager.green);
        return true;
      },
    );
  }

  onTapSelected(int index) async {
    final data = await selectProduct(products[index].id);
    if (data) {
      for (var element in products) {
        if (element.isSelected) {
          element.isSelected = false;
        }
      }
      products[index].isSelected = true;
    }
    _products.refresh();
  }

  @override
  void onInit() async {
    market = Get.arguments;
    if (!market.subcategories.any((element) => element.id == 0)) {
      market.subcategories.insert(
          0,
          UniqueSubCategoryEntity(
            id: 0,
            name: AppStrings.myOwn,
            patterns: [],
          ));
    }
    tabController =
        TabController(length: market.subcategories.length, vsync: this);
    tabController.addListener(() {
      currentIndex = tabController.index;
    });
    await getProduct();
    super.onInit();
  }
}
