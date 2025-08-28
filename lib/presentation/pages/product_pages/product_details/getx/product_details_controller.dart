import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/model/store_model/product_model.dart';
import 'package:new_sai/data/model/store_model/product_quantity_options_model.dart';
import 'package:new_sai/domain/entity/store_entity/product_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_quantity_options_entity.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_product_details_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/store/getx/store_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/getx/cart_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/model/cart_local_model.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ProductDetailsController extends GetxController {
  late int params;
  final GetProductDetailsUseCase _getProductDetailsUseCase =
      instance<GetProductDetailsUseCase>();
  final cartController = Get.find<CartController>();

  final RxBool _loadingGetProduct = false.obs;
  final Rx<ProductEntity> _product = ProductModel().toDomain().obs;
  final RxList<ProductEntity> _similarProduct = <ProductEntity>[].obs;
  final RxInt _quantity = 1.obs;
  final RxMap<int, dynamic> _optionIDValues = <int, dynamic>{}.obs;
  final RxInt _cureentImageIndex = 0.obs;

  bool get loadingGetProduct => _loadingGetProduct.value;

  ProductEntity get product => _product.value;

  List<ProductEntity> get similarProduct => _similarProduct;

  int get quantity => _quantity.value;

  Map<int, dynamic> get optionIDValues => _optionIDValues;

  int get cureentImageIndex => _cureentImageIndex.value;

  set loadingGetProduct(value) => _loadingGetProduct.value = value;

  set product(ProductEntity value) => _product.value = value;

  set similarProduct(List<ProductEntity> value) =>
      _similarProduct.value = value;

  set quantity(value) => _quantity.value = value;

  set optionIDValues(Map<int, dynamic> value) => _optionIDValues.value = value;

  set cureentImageIndex(value) => _cureentImageIndex.value = value;

  getProductDetails() async {
    loadingGetProduct = true;
    (await _getProductDetailsUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        product = r.product;
        similarProduct = r.relatedProducts;
        quantity = getProductMinQuantity();
      },
    );
    loadingGetProduct = false;
  }

  onTapFavorite() async {
    final lastStatus = product.isMyFavorite == 1;
    product.isMyFavorite = lastStatus ? 0 : 1;
    _product.refresh();
    bool success = await addRemoveFavorite(product.id);

    if (success) {
      if (lastStatus) {
        product.isMyFavorite = 0;
      } else {
        product.isMyFavorite = 1;
      }
    } else {
      product.isMyFavorite = lastStatus ? 1 : 0;
    }
    _product.refresh();
    if (Get.isRegistered<StoreController>()) {
      Get.find<StoreController>().getHomeData();
    }
  }

  onTapFavoriteOnList(int index) async {
    final lastStatus = similarProduct[index].isMyFavorite == 1;
    similarProduct[index].isMyFavorite = lastStatus ? 0 : 1;
    _similarProduct.refresh();
    bool success = await addRemoveFavorite(similarProduct[index].id);

    if (success) {
      if (lastStatus) {
        similarProduct[index].isMyFavorite = 0;
      } else {
        similarProduct[index].isMyFavorite = 1;
      }
    } else {
      similarProduct[index].isMyFavorite = lastStatus ? 1 : 0;
    }
    _similarProduct.refresh();
    if (Get.isRegistered<StoreController>()) {
      Get.find<StoreController>().getHomeData();
    }
  }

  onIncreaseQuantity() {
    if (getProductMaxQuantity() == 0) {
      showSnackBarWidget(message: AppStrings.productIsOutOfStock);
      return;
    }
    if (getProductMaxQuantity() == -2) {
      showSnackBarWidget(
          message: AppStrings
              .youCanIncreaseTheProductWhenChoosingTheSpecificOptions);
      return;
    }
    if (getProductMaxQuantity() == -1) {
      quantity += 1;
    } else {
      if (quantity < getProductMaxQuantity()) {
        quantity += 1;
      } else {
        showSnackBarWidget(
          message:
              AppStrings.maximumNumberOfProductsIs(getProductMaxQuantity()),
        );
      }
    }
  }

  onDecreaseQuantity() {
    if (quantity > getProductMinQuantity()) {
      quantity -= 1;
    }
  }

  num getProductPrice() {
    if (product.options.isEmpty) {
      if (product.offerPrice != 0) {
        return product.offerPrice;
      } else {
        return product.buyPrice;
      }
    } else {
      num price = 0;
      for (var element in product.options) {
        optionIDValues.forEach((key, value) {
          if (value is bool && value == true) {
            price += element.price;
          }
        });
      }
      return getOptionQuantity().buyPrice == 0
          ? getOptionQuantity().buyPrice
          : (getOptionQuantity().buyPrice + price);
    }
  }

  num getProductMaxQuantity() {
    if (product.options.isEmpty) {
      if (product.quantity == -1) {
        if (product.maxOrderQnt != 0) {
          return product.maxOrderQnt;
        } else {
          return product.quantity;
        }
      } else {
        return product.quantity;
      }
    } else {
      if (getOptionQuantity().quantityOptionId == 0) {
        return -2;
      }
      if (getOptionQuantity().qnt == -1) {
        if (getOptionQuantity().maxOrderQnt != 0) {
          return getOptionQuantity().maxOrderQnt;
        } else {
          return getOptionQuantity().qnt;
        }
      } else {
        return getOptionQuantity().qnt;
      }
    }
  }

  num getProductMinQuantity() {
    if (product.options.isEmpty) {
      if (product.minOrderQnt != 0) {
        return product.minOrderQnt;
      } else {
        return 1;
      }
    } else {
      if (getOptionQuantity().quantityOptionId == 0) {
        return 0;
      }
      if (getOptionQuantity().minOrderQnt != 0) {
        return getOptionQuantity().minOrderQnt;
      } else {
        return 1;
      }
    }
  }

  ProductQuantityOptionEntity getOptionQuantity() {
    ProductQuantityOptionEntity option =
        ProductQuantityOptionsModel().toDomain();

    for (var element in product.quantityOptions) {
      bool allExist = false;
      final map = <int, int>{};
      final list = <int>[];
      optionIDValues.values.toList().forEach((e) {
        if (e is int) {
          list.add(e);
        }
      });
      for (var element2 in element.optionValueId) {
        map[element2.option] = element2.value;
      }
      const listEquality = ListEquality();
      allExist = listEquality.equals(map.values.toList(), list);
      if (allExist) {
        option = element;
        break;
      }
    }

    return option;
  }

  onChangeOptionValue(int index, value) {
    optionIDValues[product.options[index].id] = value;
    if (getOptionQuantity().quantityOptionId != 0) {
      quantity = getProductMinQuantity();
    }
    _optionIDValues.refresh();
  }

  addToCart() {
    if (product.options.isEmpty) {
      final model = CartLocalModel(
        image: product.images.isNotEmpty ? product.images.first.imagePath : "",
        title: product.name,
        price: getProductPrice(),
        quantity: quantity,
        minQuantity: getProductMinQuantity().toInt(),
        maxQuantity: getProductMaxQuantity().toInt(),
        id: product.id,
      );
      cartController.addToCart(model);
      showSnackBarWidget(
        message: AppStrings.theProductHasBeenAddedToTheCart,
        color: ColorManager.green,
      );
    } else {
      if (getOptionQuantity().quantityOptionId == 0) {
        showSnackBarWidget(message: AppStrings.pleaseChooseOptionsFirst);
      } else {
        List<int> optionalOption = [];
        optionIDValues.forEach((key, value) {
          if (value is bool) {
            optionalOption.add(key);
          }
        });
        final model = CartLocalModel(
          image:
              product.images.isNotEmpty ? product.images.first.imagePath : "",
          title: product.name,
          price: getProductPrice(),
          quantity: quantity,
          minQuantity: getProductMinQuantity().toInt(),
          maxQuantity: getProductMaxQuantity().toInt(),
          quantityOptionId: getOptionQuantity().quantityOptionId,
          optionalOption: optionalOption,
          id: product.id,
        );
        cartController.addToCart(model);
        showSnackBarWidget(
          message: AppStrings.theProductHasBeenAddedToTheCart,
          color: ColorManager.green,
        );
      }
    }
  }

  @override
  void onInit() async {
    params = Get.arguments;
    await getProductDetails();
    super.onInit();
  }
}
