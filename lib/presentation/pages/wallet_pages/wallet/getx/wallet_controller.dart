import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/record_entity.dart';
import 'package:new_sai/domain/entity/wallet_entity/units_entity.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_bounce_records_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_gift_records_use_case.dart';
import 'package:new_sai/domain/use_case/wallet_use_case/get_charging_units_use_case.dart';
import 'package:new_sai/presentation/pages/wallet_pages/charge_wallet/getx/charge_wallet_controller.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class WalletController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final appController = Get.find<AppController>();
  // final chargeWalletController = Get.find<ChargeWalletController>();
  final bounceScrollController = ScrollController();
  final giftController = ScrollController();
  final GetBounceRecordsUseCase _bounceRecordsUseCase =
      instance<GetBounceRecordsUseCase>();
  final GetGiftRecordsUseCase _getGiftRecordsUseCase =
      instance<GetGiftRecordsUseCase>();
  int bouncePage = 1;
  int giftPage = 1;

  final RxBool _loadingBounce = false.obs;
  final RxBool _loadingBouncePagination = false.obs;
  final RxBool _loadingGift = false.obs;
  final RxBool _loadingGiftPagination = false.obs;
  final RxList<RecordEntity> _bounces = <RecordEntity>[].obs;
  final RxList<RecordEntity> _gifts = <RecordEntity>[].obs;
  final Rx<PaginationEntity> _bouncePagination =
      PaginationModel().toDomain().obs;
  final Rx<PaginationEntity> _giftPagination = PaginationModel().toDomain().obs;

  bool get loadingBounce => _loadingBounce.value;
  bool get loadingBouncePagination => _loadingBouncePagination.value;
  bool get loadingGift => _loadingGift.value;
  bool get loadingGiftPagination => _loadingGiftPagination.value;
  List<RecordEntity> get bounces => _bounces;
  List<RecordEntity> get gifts => _gifts;
  PaginationEntity get bouncePagination => _bouncePagination.value;
  PaginationEntity get giftPagination => _giftPagination.value;

  set loadingBounce(value) => _loadingBounce.value = value;
  set loadingBouncePagination(value) => _loadingBouncePagination.value = value;
  set loadingGift(value) => _loadingGift.value = value;
  set loadingGiftPagination(value) => _loadingGiftPagination.value = value;
  set bounces(List<RecordEntity> value) => _bounces.value = value;
  set gifts(List<RecordEntity> value) => _gifts.value = value;
  set bouncePagination(PaginationEntity value) =>
      _bouncePagination.value = value;
  set giftPagination(PaginationEntity value) => _giftPagination.value = value;

  getBounceRecords({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingBouncePagination = true;
    } else {
      loadingBounce = true;
      bouncePage = 1;
      bounces.clear();
    }
    (await _bounceRecordsUseCase.execute(bouncePage)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        bounces.addAll(r.data);
        bouncePagination = r.pagination;
        bouncePage++;
      },
    );
    loadingBounce = false;
    loadingBouncePagination = false;
  }

  getGiftRecords({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingGiftPagination = true;
    } else {
      loadingGift = true;
      giftPage = 1;
      gifts.clear();
    }
    (await _getGiftRecordsUseCase.execute(giftPage)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        gifts.addAll(r.data);
        giftPagination = r.pagination;
        giftPage++;
      },
    );
    loadingGift = false;
    loadingGiftPagination = false;
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
    bounceScrollController.addListener(() async {
      if (bounceScrollController.offset ==
          bounceScrollController.position.maxScrollExtent) {
        if (bouncePagination.nextPageUrl.isNotEmpty &&
            !loadingBouncePagination) {
          await getBounceRecords(isPaginate: true);
        }
      }
    });
    giftController.addListener(() async {
      if (giftController.offset == giftController.position.maxScrollExtent) {
        if (giftPagination.nextPageUrl.isNotEmpty && !loadingGiftPagination) {
          await getGiftRecords(isPaginate: true);
        }
      }
    });
    await getBounceRecords();
    await getChargingUnits();
    await getGiftRecords();

    // await chargeWalletController.getChargingUnits();
    super.onInit();
  }
}
