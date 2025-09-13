import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/redeems_record_entity.dart';
import 'package:new_sai/domain/entity/wallet_entity/units_entity.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_my_redeems_record_use_case.dart';
import 'package:new_sai/domain/use_case/wallet_use_case/get_charging_units_use_case.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class CashWithdrawalController extends GetxController with  GetSingleTickerProviderStateMixin{

  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  late TabController tabController;
  final appController = Get.find<AppController>();
  final goldValueController = TextEditingController();
  final GetMyRedeemsRecordUseCase _getMyRedeemsRecordUseCase =
      instance<GetMyRedeemsRecordUseCase>();
  int page = 1;

  final RxBool _getMyRecord = false.obs;
  final RxBool _getMyRecordPagination = false.obs;
  final RxList<RedeemsRecordEntity> _records = <RedeemsRecordEntity>[].obs;
  final Rx<PaginationEntity> _pagination = PaginationModel().toDomain().obs;
  final RxDouble _total = 0.0.obs;

  bool get getMyRecord => _getMyRecord.value;
  bool get getMyRecordPagination => _getMyRecordPagination.value;
  List<RedeemsRecordEntity> get records => _records;
  PaginationEntity get pagination => _pagination.value;
  double get total => _total.value;

  set getMyRecord(value) => _getMyRecord.value = value;
  set getMyRecordPagination(value) => _getMyRecordPagination.value = value;
  set records(List<RedeemsRecordEntity> value) => _records.value = value;
  set pagination(PaginationEntity value) => _pagination.value = value;
  set total(value) => _total.value = value;

  getMyRecords({bool isPaginate = false}) async {
    if (isPaginate) {
      getMyRecordPagination = true;
    } else {
      getMyRecord = true;
      records.clear();
      page = 1;
    }
    (await _getMyRedeemsRecordUseCase.execute(page)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        records.addAll(r.data);
        pagination = r.pagination;
        page++;
      },
    );
    getMyRecord = false;
    getMyRecordPagination = false;
  }

  onTapAll() {
    goldValueController.text = appController.user.goldValue.toString();
  }

  onGoToNextPage() async {
    if (formKey.currentState!.validate()) {
      if (num.parse(goldValueController.text) > appController.user.goldValue) {
        showSnackBarWidget(
            message: AppStrings
                .theSpecifiedValueIsGreaterThanTheNumberOfAvailableCurrencies);
        return;
      }
      Get.toNamed(AppRoutes.paymentMethodRoute);
    }
  }

  checkIfValidValue() {
    if (AppValidation.validateRedeemes(
          goldValueController.text,
          appController.user.goldValue,
        ) ==
        null) {
      total = (num.parse(goldValueController.text) / 150);
    } else {
      total = 0.0;
    }
  }

  final getChargingUnitUseCase = instance<GetChargingUnitsUseCase>();
  UnitEntity? unitEntity;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;
  getChargingUnits() async {
    isLoading = true;
    var result = await getChargingUnitUseCase.execute("");
    result.fold((ifLeft) {
      showSnackBarWidget(message: ifLeft.message);
    }, (units) {
      unitEntity = units;
    });
    isLoading = false;
  }

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this);
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (pagination.nextPageUrl.isNotEmpty && !getMyRecordPagination) {
          await getMyRecords(isPaginate: true);
        }
      }
    });
    await getChargingUnits();
    goldValueController.addListener(() {
      checkIfValidValue();
    });
    await getMyRecords();
    super.onInit();
  }
}
