import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/model/store_model/order_details_model.dart';
import 'package:new_sai/domain/entity/store_entity/order_details_entity.dart';
import 'package:new_sai/domain/use_case/store_use_case/cancel_order_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_order_details_use_case.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/widgets/cancel_order_dialog.dart';
import 'package:new_sai/presentation/pages/product_pages/orders/getx/orders_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class OrderDetailsController extends GetxController {
  late int id;
  final GetOrderDetailsUseCase _detailsUseCase =
      instance<GetOrderDetailsUseCase>();
  final CancelOrderUseCase _cancelOrderUseCase = instance<CancelOrderUseCase>();

  final RxBool _loadingOrder = false.obs;
  final Rx<OrderDetailsEntity> _order = OrderDetailsModel().toDomain().obs;

  bool get loadingOrder => _loadingOrder.value;
  OrderDetailsEntity get order => _order.value;

  set loadingOrder(value) => _loadingOrder.value = value;
  set order(OrderDetailsEntity value) => _order.value = value;

  getOrderDetails() async {
    loadingOrder = true;
    (await _detailsUseCase.execute(id)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        order = r;
      },
    );
    loadingOrder = false;
  }

  cancelOrder() async {
    final isCancel =
        await Get.dialog(const CancelOrderDialog(), barrierDismissible: false);
    if (isCancel) {
      showAppLoadingDialog();
      (await _cancelOrderUseCase.execute(id)).fold(
        (l) {
          Get.back();
          showSnackBarWidget(message: l.message);
        },
        (r) {
          Get.back();
          Get.until((route) {
            if (Get.currentRoute == AppRoutes.ordersRoute) {
              return true;
            }
            return false;
          });
          Get.find<OrdersController>().getOrders();
        },
      );
    }
  }

  @override
  void onInit() async {
    id = Get.arguments;
    await getOrderDetails();
    super.onInit();
  }
}
