import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_entity.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_my_favorite_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/store/getx/store_controller.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class FavoriteController extends GetxController {
  final scrollController = ScrollController();
  final GetMyFavoriteUseCase _favoriteUseCase =
      instance<GetMyFavoriteUseCase>();

  final RxBool _loading = false.obs;
  final RxBool _loadingPagination = false.obs;
  final RxList<ProductEntity> _products = <ProductEntity>[].obs;
  final Rx<PaginationEntity> _paginationData = PaginationModel().toDomain().obs;
  int page = 1;

  bool get loading => _loading.value;
  bool get loadingPagination => _loadingPagination.value;
  List<ProductEntity> get products => _products;
  PaginationEntity get paginationData => _paginationData.value;

  set loading(value) => _loading.value = value;
  set loadingPagination(value) => _loadingPagination.value = value;
  set products(List<ProductEntity> value) => _products.value = value;
  set paginationData(PaginationEntity value) => _paginationData.value = value;

  getMyFavorite({bool isPaginat = false}) async {
    if (isPaginat) {
      loadingPagination = true;
    } else {
      page = 1;
      _products.clear();
      loading = true;
    }
    (await _favoriteUseCase.execute(page)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        page++;
        products.addAll(r.data);
        paginationData = r.pagination;
      },
    );
    loadingPagination = false;
    loading = false;
  }

  onTapFavorite(int index) async {
    final lastStatus = products[index].isMyFavorite == 1;
    products[index].isMyFavorite = lastStatus ? 0 : 1;
    _products.refresh();
    bool success = await addRemoveFavorite(products[index].id);
    if (success) {
      if (lastStatus) {
        products.removeAt(index);
      } else {
        products[index].isMyFavorite = 1;
      }
    } else {
      products[index].isMyFavorite = lastStatus ? 1 : 0;
    }
    _products.refresh();
    if (Get.isRegistered<StoreController>()) {
      Get.find<StoreController>().getHomeData();
    }
  }

  @override
  void onInit() async {
    await getMyFavorite();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (paginationData.nextPageUrl.isNotEmpty) {
          getMyFavorite(isPaginat: true);
        }
      }
    });
    super.onInit();
  }
}
