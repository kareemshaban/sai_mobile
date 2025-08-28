import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/mapper/room_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/room_model/room_model.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_banners_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_entity.dart';
import 'package:new_sai/domain/use_case/app_use_case/get_country_list_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_famous_rooms_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_memper_rooms_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_my_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_popular_rooms_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_banners_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

import '../../../../../../data/model/game_model/game_model.dart';

class RoomsController extends GetxController {
  final popularScrollController = ScrollController();
  final famousScrollController = ScrollController();
  final memperScrollController = ScrollController();
  final GetCountryListUseCase _countryListUseCase =
      instance<GetCountryListUseCase>();
  final GetPopularRoomsUseCase _getPopularRoomsUseCase =
      instance<GetPopularRoomsUseCase>();
  final GetFamousRoomsUseCase _getFamousRoomsUseCase =
      instance<GetFamousRoomsUseCase>();
  final GetMemperRoomsUseCase _getMemperRoomsUseCase =
      instance<GetMemperRoomsUseCase>();
  final GetRoomBannersUseCase _bannersUseCase =
      instance<GetRoomBannersUseCase>();
  final GetMyRoomUseCase _getMyRoomUseCase = instance<GetMyRoomUseCase>();
  RoomEntity myRoom = RoomModel().toDomain();
  List<CountryEntity> countries = [];
  int popularPage = 1;
  int famousPage = 1;
  int memperPage = 1;

  final RxInt _currentIndex = 2.obs;
  final RxBool _loadingMyRoom = false.obs;
  final RxBool _loadingCountry = false.obs;
  final RxBool _loadingPopularRooms = false.obs;
  final RxBool _loadingPopularRoomsPagination = false.obs;
  final RxBool _loadingFamousRooms = false.obs;
  final RxBool _loadingFamousRoomsPagination = false.obs;
  final RxBool _loadingMemperRooms = false.obs;
  final RxBool _loadingMemperRoomsPagination = false.obs;
  final RxBool _loadingGetBanners = false.obs;
  final RxList<RoomEntity> _popularRooms = <RoomEntity>[].obs;
  final RxList<RoomEntity> _famousRooms = <RoomEntity>[].obs;
  final RxList<RoomEntity> _memperRooms = <RoomEntity>[].obs;
  final Rx<PaginationEntity> _popularPagination =
      PaginationModel().toDomain().obs;
  final Rx<PaginationEntity> _famousPagination =
      PaginationModel().toDomain().obs;
  final Rx<PaginationEntity> _memperPagination =
      PaginationModel().toDomain().obs;
  final RxList<RoomBannerItemEntity> _topBillionares =
      <RoomBannerItemEntity>[].obs;
  final RxList<RoomBannerItemEntity> _topSenders = <RoomBannerItemEntity>[].obs;
  final RxList<RoomBannerItemEntity> _topRooms = <RoomBannerItemEntity>[].obs;

  int get currentIndex => _currentIndex.value;

  bool get loadingMyRoom => _loadingMyRoom.value;

  bool get loadingCountry => _loadingCountry.value;

  bool get loadingPopularRooms => _loadingPopularRooms.value;

  bool get loadingPopularRoomsPagination =>
      _loadingPopularRoomsPagination.value;

  bool get loadingFamousRooms => _loadingFamousRooms.value;

  bool get loadingFamousRoomsPagination => _loadingFamousRoomsPagination.value;

  bool get loadingMemperRooms => _loadingMemperRooms.value;

  bool get loadingMemperRoomsPagination => _loadingMemperRoomsPagination.value;

  bool get loadingGetBanners => _loadingGetBanners.value;

  List<RoomEntity> get popularRooms => _popularRooms;

  List<RoomEntity> get famousRooms => _famousRooms;

  List<RoomEntity> get memperRooms => _memperRooms;

  PaginationEntity get popularPagination => _popularPagination.value;

  PaginationEntity get famousPagination => _famousPagination.value;

  PaginationEntity get memperPagination => _memperPagination.value;

  List<RoomBannerItemEntity> get topBillionares => _topBillionares;

  List<RoomBannerItemEntity> get topSenders => _topSenders;

  List<RoomBannerItemEntity> get topRooms => _topRooms;

  set currentIndex(value) => _currentIndex.value = value;

  set loadingMyRoom(value) => _loadingMyRoom.value = value;

  set loadingCountry(value) => _loadingCountry.value = value;

  set loadingPopularRooms(value) => _loadingPopularRooms.value = value;

  set loadingPopularRoomsPagination(value) =>
      _loadingPopularRoomsPagination.value = value;

  set loadingFamousRooms(value) => _loadingFamousRooms.value = value;

  set loadingFamousRoomsPagination(value) =>
      _loadingFamousRoomsPagination.value = value;

  set loadingMemperRooms(value) => _loadingMemperRooms.value = value;

  set loadingMemperRoomsPagination(value) =>
      _loadingMemperRoomsPagination.value = value;

  set loadingGetBanners(value) => _loadingGetBanners.value = value;

  set popularRooms(List<RoomEntity> value) => _popularRooms.value = value;

  set famousRooms(List<RoomEntity> value) => _famousRooms.value = value;

  set memperRooms(List<RoomEntity> value) => _memperRooms.value = value;

  set popularPagination(PaginationEntity value) =>
      _popularPagination.value = value;

  set famousPagination(PaginationEntity value) =>
      _famousPagination.value = value;

  set memperPagination(PaginationEntity value) =>
      _memperPagination.value = value;

  set topBillionares(List<RoomBannerItemEntity> value) =>
      _topBillionares.value = value;

  set topSenders(List<RoomBannerItemEntity> value) => _topSenders.value = value;

  set topRooms(List<RoomBannerItemEntity> value) => _topRooms.value = value;

  onChangeIndex(int value) async {
    currentIndex = value;
    switch (value) {
      case 0:
        await getMyOwnPage();
      case 1:
        await getPopularRooms();
      case 2:
        await getGeneralPage();
    }
  }

  getMyRoom() async {
    loadingMyRoom = true;
    (await _getMyRoomUseCase.execute("")).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        myRoom = r;
      },
    );
    loadingMyRoom = false;
  }

  getCountryList() async {
    loadingCountry = true;
    (await _countryListUseCase.execute('')).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        countries = r;
      },
    );
    loadingCountry = false;
  }

  getPopularRooms({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingPopularRoomsPagination = true;
    } else {
      loadingPopularRooms = true;
      popularPage = 1;
      popularRooms.clear();
    }
    (await _getPopularRoomsUseCase.execute(popularPage)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        popularPage++;
        popularPagination = r.pagination;
        popularRooms.addAll(r.data);
      },
    );
    loadingPopularRooms = false;
    loadingPopularRoomsPagination = false;
  }

  getFamousRooms({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingFamousRoomsPagination = true;
    } else {
      loadingFamousRooms = true;
      famousPage = 1;
      famousRooms.clear();
    }
    (await _getFamousRoomsUseCase.execute(famousPage)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        famousPage++;
        famousPagination = r.pagination;
        famousRooms.addAll(r.data);
      },
    );
    loadingFamousRooms = false;
    loadingFamousRoomsPagination = false;
  }

  getMemperRooms({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingMemperRoomsPagination = true;
    } else {
      loadingMemperRooms = true;
      memperPage = 1;
      memperRooms.clear();
    }
    (await _getMemperRoomsUseCase.execute(memperPage)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        memperPage++;
        memperPagination = r.pagination;
        memperRooms.addAll(r.data);
      },
    );
    loadingMemperRooms = false;
    loadingMemperRoomsPagination = false;
  }

  getGeneralPage() async {
    loadingCountry = true;
    loadingFamousRooms = true;
    loadingGetBanners = true;
    await getCountryList();
    await getRoomBanners();
    await getFamousRooms();
  }

  getMyOwnPage() async {
    loadingMyRoom = true;
    loadingMemperRooms = true;
    await getMyRoom();
    await getMemperRooms();
  }

  getRoomBanners() async {
    topSenders.clear();
    topBillionares.clear();
    topRooms.clear();
    loadingGetBanners = true;
    (await _bannersUseCase.execute('')).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        if (r.topBillionares.isNotEmpty) {
          topBillionares.add(r.topBillionares.first);
        }
        if (r.topSenders.isNotEmpty) {
          topSenders.add(r.topSenders.first);
        }
        if (r.topRooms.isNotEmpty) {
          topRooms.add(r.topRooms.first);
        }
      },
    );
    loadingGetBanners = false;
  }

  @override
  void onInit() async {
    popularScrollController.addListener(() async {
      if (popularScrollController.offset ==
          popularScrollController.position.maxScrollExtent) {
        if (popularPagination.nextPageUrl.isNotEmpty) {
          await getPopularRooms(isPaginate: true);
        }
      }
    });
    famousScrollController.addListener(() async {
      if (famousScrollController.offset ==
          famousScrollController.position.maxScrollExtent) {
        if (famousPagination.nextPageUrl.isNotEmpty) {
          await getFamousRooms(isPaginate: true);
        }
      }
    });
    memperScrollController.addListener(() async {
      if (memperScrollController.offset ==
          memperScrollController.position.maxScrollExtent) {
        if (memperPagination.nextPageUrl.isNotEmpty) {
          await getMemperRooms(isPaginate: true);
        }
      }
    });
    if (!isGuest()) {
      await getGeneralPage();
    }
    super.onInit();
  }
}
