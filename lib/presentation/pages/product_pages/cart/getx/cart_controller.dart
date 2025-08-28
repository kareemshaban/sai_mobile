import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/model/cart_local_model.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class CartController extends GetxController {
  final cartBox = Hive.box<CartLocalModel>("CartLocalModel");

  final RxList<CartLocalModel> _products = <CartLocalModel>[].obs;

  List<CartLocalModel> get products => _products;

  set products(List<CartLocalModel> value) => _products.value = value;

  addToCart(CartLocalModel model) {
    products.add(model);
    cartBox.add(model);
  }

  onIncreaceProduct(int index) {
    if (products[index].maxQuantity != -1) {
      if (products[index].quantity < products[index].maxQuantity) {
        products[index].quantity += 1;
      } else {
        showSnackBarWidget(
          message:
              AppStrings.maximumNumberOfProductsIs(products[index].maxQuantity),
        );
      }
    } else {
      products[index].quantity += 1;
    }
    _products.refresh();
    cartBox.putAt(index, products[index]);
  }

  onDecreaceProduct(int index) {
    if (products[index].quantity > products[index].minQuantity) {
      products[index].quantity -= 1;
    } else {
      showSnackBarWidget(
        message: AppStrings.minNumberOfProductsIs(products[index].minQuantity),
      );
    }
    _products.refresh();
    cartBox.putAt(index, products[index]);
  }

  onDeleteProduct(int index) {
    cartBox.deleteAt(index);
    products.removeAt(index);
  }

  num getAllProductPrice() {
    num price = 0;
    for (var element in products) {
      price += element.price * element.quantity;
    }
    return price;
  }

  deleteCard() {
    products.clear();
    cartBox.deleteAll(cartBox.keys);
  }

  @override
  void onInit() {
    products = cartBox.values.toList();
    super.onInit();
  }
}
