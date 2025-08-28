import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/store_model/category_model.dart';
import 'package:new_sai/data/params/store_params/product_search_params.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/store_entity/category_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_option_entity.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_product_filter_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/search_product_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/store/getx/store_controller.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class CategorySearchController extends GetxController {
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  final GetProductFilterUseCase _filterUseCase =
      instance<GetProductFilterUseCase>();
  final SearchProductUseCase _searchProductUseCase =
      instance<SearchProductUseCase>();
  int page = 1;

  final Rx<CategoryEntity> _category = CategoryModel().toDomain().obs;
  final RxBool _loadingGetFilter = false.obs;
  final RxBool _loadingSearch = false.obs;
  final RxBool _loadingSearchPagination = false.obs;
  final RxList<CategoryEntity> _categories = <CategoryEntity>[].obs;
  final RxList<ProductOptionEntity> _options = <ProductOptionEntity>[].obs;
  final RxList<ProductEntity> _products = <ProductEntity>[].obs;
  final Rx<PaginationEntity> _pagination = PaginationModel().toDomain().obs;
  final RxString _sortTypeValue = ''.obs;
  final RxMap<int, int> _optionsValues = <int, int>{}.obs;

  CategoryEntity get category => _category.value;
  bool get loadingGetFilter => _loadingGetFilter.value;
  bool get loadingSearch => _loadingSearch.value;
  bool get loadingSearchPagination => _loadingSearchPagination.value;
  List<CategoryEntity> get categories => _categories;
  List<ProductOptionEntity> get options => _options;
  List<ProductEntity> get products => _products;
  PaginationEntity get pagination => _pagination.value;
  String get sortTypeValue => _sortTypeValue.value;
  Map<int, int> get optionsValues => _optionsValues;

  set category(CategoryEntity value) => _category.value = value;
  set loadingGetFilter(value) => _loadingGetFilter.value = value;
  set loadingSearch(value) => _loadingSearch.value = value;
  set loadingSearchPagination(value) => _loadingSearchPagination.value = value;
  set categories(List<CategoryEntity> value) => _categories.value = value;
  set options(List<ProductOptionEntity> value) => _options.value = value;
  set products(List<ProductEntity> value) => _products.value = value;
  set pagination(PaginationEntity value) => _pagination.value = value;
  set sortTypeValue(value) => _sortTypeValue.value = value;
  set optionsValues(Map<int, int> value) => _optionsValues.value = value;

  getFilters() async {
    loadingGetFilter = true;
    (await _filterUseCase.execute("")).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        categories = r.categories;
        options = r.options;
      },
    );
    loadingGetFilter = false;
  }

  searchProduct({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingSearchPagination = true;
    } else {
      loadingSearch = true;
      page = 1;
      products.clear();
    }
    final list = <ProductSearchOptionParams>[];
    optionsValues.forEach((key, value) {
      list.add(ProductSearchOptionParams(
        value: value,
        id: key,
      ));
    });
    final params = ProductSearchParams(
      page: page,
      search: searchController.text,
      categoryId: category.id,
      sortType: sortTypeValue.isNotEmpty ? sortTypeValue : null,
      options: list,
    );
    (await _searchProductUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        products.addAll(r.data);
        pagination = r.pagination;
        page++;
      },
    );
    loadingSearch = false;
    loadingSearchPagination = false;
  }

  onTapFavoriteOnList(int index) async {
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

  onChangeSortTypeValue(value) {
    Get.back();
    sortTypeValue = value;
    searchProduct();
  }

  @override
  void onInit() async {
    category = Get.arguments;
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (pagination.nextPageUrl.isNotEmpty && !loadingSearchPagination) {
          await searchProduct(isPaginate: true);
        }
      }
    });
    loadingSearch = true;
    await getFilters();
    await searchProduct();
    super.onInit();
  }
}
