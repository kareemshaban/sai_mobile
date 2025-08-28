import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/enums.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/store_entity/order_entity.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_orders_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class OrdersController extends GetxController {
  final scrollController = ScrollController();
  int page = 1;
  final GetOrdersUseCase _getOrdersUseCase = instance<GetOrdersUseCase>();

  final RxBool _loading = false.obs;
  final RxBool _loadingPagination = false.obs;
  final RxList<OrderEntity> _currentOrders = <OrderEntity>[].obs;
  final RxList<OrderEntity> _previosOrders = <OrderEntity>[].obs;
  final Rx<PaginationEntity> _orderPagination =
      PaginationModel().toDomain().obs;

  bool get loading => _loading.value;
  bool get loadingPagination => _loadingPagination.value;
  List<OrderEntity> get currentOrders => _currentOrders;
  List<OrderEntity> get previosOrders => _previosOrders;
  PaginationEntity get orderPagination => _orderPagination.value;

  set loading(value) => _loading.value = value;
  set loadingPagination(value) => _loadingPagination.value = value;
  set currentOrders(List<OrderEntity> value) => _currentOrders.value = value;
  set previosOrders(List<OrderEntity> value) => _previosOrders.value = value;
  set orderPagination(PaginationEntity value) => _orderPagination.value = value;

  getOrders({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingPagination = true;
    } else {
      loading = true;
      page = 1;
      currentOrders.clear();
      previosOrders.clear();
    }
    (await _getOrdersUseCase.execute(page)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        for (var element in r.data) {
          if (element.statue == OrderState.inDelivery ||
              element.statue == OrderState.newOrder ||
              element.statue == OrderState.readyForDispatch ||
              element.statue == OrderState.underPreparation) {
            currentOrders.add(element);
          } else {
            previosOrders.add(element);
          }
        }
        page++;
        orderPagination = r.pagination;
      },
    );
    loading = false;
    loadingPagination = false;
  }

  @override
  void onInit() async {
    await getOrders();
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (orderPagination.nextPageUrl.isNotEmpty) {
          await getOrders(isPaginate: true);
        }
      }
    });
    super.onInit();
  }
}
