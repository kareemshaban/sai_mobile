import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/params/store_params/product_search_params.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_entity.dart';
import 'package:new_sai/domain/use_case/store_use_case/search_product_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/store/getx/store_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/product_search/model/last_search_local_model.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ProductSearchController extends GetxController {
  final searchController = TextEditingController();
  final SearchProductUseCase _searchProductUseCase =
      instance<SearchProductUseCase>();
  final scrollController = ScrollController();
  int page = 1;
  final lastSearchBox = Hive.box<LastSearchLocalModel>("LastSearchLocalModel");

  final RxBool _loadingSearch = false.obs;
  final RxBool _loadingSearchPagination = false.obs;
  final RxList<ProductEntity> _products = <ProductEntity>[].obs;
  final Rx<PaginationEntity> _pagination = PaginationModel().toDomain().obs;
  final RxList<LastSearchLocalModel> _lastSearches =
      <LastSearchLocalModel>[].obs;
  final RxBool _isSearchEmpty = true.obs;

  bool get loadingSearch => _loadingSearch.value;
  bool get loadingSearchPagination => _loadingSearchPagination.value;
  List<ProductEntity> get products => _products;
  PaginationEntity get pagination => _pagination.value;
  List<LastSearchLocalModel> get lastSearches => _lastSearches;
  bool get isSearchEmpty => _isSearchEmpty.value;

  set loadingSearch(value) => _loadingSearch.value = value;
  set loadingSearchPagination(value) => _loadingSearchPagination.value = value;
  set products(List<ProductEntity> value) => _products.value = value;
  set pagination(PaginationEntity value) => _pagination.value = value;
  set lastSearches(List<LastSearchLocalModel> value) =>
      _lastSearches.value = value;
  set isSearchEmpty(value) => _isSearchEmpty.value = value;

  searchProduct({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingSearchPagination = true;
    } else {
      loadingSearch = true;
      products.clear();
      page = 1;
    }
    final params = ProductSearchParams(
      search: searchController.text,
      page: page,
    );
    (await _searchProductUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        products.addAll(r.data);
        pagination = r.pagination;
        page++;
        if (r.data.isNotEmpty) {
          if (!lastSearches.any((element) => element.id == r.data.first.id)) {
            final data = LastSearchLocalModel(
              id: r.data.first.id,
              image: r.data.first.image,
              name: r.data.first.name.split(" ").first,
            );
            lastSearches.add(data);
            lastSearchBox.add(data);
          }
        }
      },
    );
    loadingSearch = false;
    loadingSearchPagination = false;
  }

  onTapFavorite(int index) async {
    final lastStatus = products[index].isMyFavorite == 1;
    products[index].isMyFavorite = lastStatus ? 0 : 1;
    _products.refresh();
    bool success = await addRemoveFavorite(products[index].id);

    if (success) {
      if (lastStatus) {
        products[index].isMyFavorite = 0;
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
  void onInit() {
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (pagination.nextPageUrl.isNotEmpty && !loadingSearchPagination) {
          await searchProduct(isPaginate: true);
        }
      }
    });
    searchController.addListener(() {
      isSearchEmpty = searchController.text.isEmpty;
      if (isSearchEmpty) {
        products.clear();
      }
    });
    lastSearches = lastSearchBox.values.toList();
    super.onInit();
  }
}
