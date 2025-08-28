import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/app_search_model.dart';
import 'package:new_sai/data/params/app_params/app_search_params.dart';
import 'package:new_sai/domain/entity/app_entity/app_search_entity.dart';
import 'package:new_sai/domain/use_case/app_use_case/get_app_search_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class SearchPostController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final searchController = TextEditingController();
  late TabController tabController;
  final GetAppSearchUseCase _appSearchUseCase = instance<GetAppSearchUseCase>();
  AppSearchEntity data = AppSearchModel().toDomain();

  final RxBool _loading = false.obs;
  final RxInt _cureentIndex = 0.obs;

  bool get loading => _loading.value;
  int get cureentIndex => _cureentIndex.value;

  set loading(value) => _loading.value = value;
  set cureentIndex(value) => _cureentIndex.value = value;

  onChangeCurrentIndex(value) {
    cureentIndex = value;
  }

  search() async {
    if (searchController.text.isEmpty) {
      data.users.clear();
      data.videos.clear();
      data.hashTags.clear();
      loading = true;
      loading = false;
      return;
    }
    loading = true;
    final params = AppSearchParams(
      filter: cureentIndex == 0
          ? "all"
          : cureentIndex == 1
              ? "video"
              : cureentIndex == 2
                  ? "users"
                  : "hash_tag",
      search: searchController.text,
    );
    (await _appSearchUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        data = r;
      },
    );
    loading = false;
  }

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }
}
