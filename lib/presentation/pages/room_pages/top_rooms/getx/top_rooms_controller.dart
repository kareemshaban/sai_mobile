import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/params/room_params/global_statistics_params.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_global_statistics_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class TopRoomsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final appController = Get.find<AppController>();
  final GetGlobalStatisticsUseCase _getGlobalStatisticsUseCase =
      instance<GetGlobalStatisticsUseCase>();

  final RxString _filterValue = "topRooms".obs;
  final RxBool _loadingGlobal = false.obs;
  final RxInt _currntIndex = 0.obs;
  final RxList<UserEntity> _users = <UserEntity>[].obs;

  String get filterValue => _filterValue.value;
  bool get loadingGlobal => _loadingGlobal.value;
  int get currntIndex => _currntIndex.value;
  List<UserEntity> get users => _users;

  set filterValue(value) => _filterValue.value = value;
  set loadingGlobal(value) => _loadingGlobal.value = value;
  set currntIndex(value) => _currntIndex.value = value;
  set users(List<UserEntity> value) => _users.value = value;

  onChangeFilterValue(String value) async {
    filterValue = value;
    await getGlobal();
  }

  getGlobal() async {
    loadingGlobal = true;
    final params = GlobalStatisticsParams(
      dateType: currntIndex == 0
          ? "hourly"
          : currntIndex == 1
              ? "daily"
              : currntIndex == 2
                  ? "weekly"
                  : "monthly",
      type: filterValue == "topRooms"
          ? 3
          : filterValue == "topSenders"
              ? 2
              : 1,
    );
    (await _getGlobalStatisticsUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        users = r;
      },
    );
    loadingGlobal = false;
  }

  @override
  void onInit() async {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() async {
      currntIndex = tabController.index;
    });
    await getGlobal();
    super.onInit();
  }
}
