import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/country_model.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_entity.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_by_country_id_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/getx/rooms_controller.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class CountryRoomController extends GetxController {
  final scrollController = ScrollController();
  final roomsController = Get.find<RoomsController>();
  final GetRoomByCountryIdUseCase _byCountryIdUseCase =
      instance<GetRoomByCountryIdUseCase>();
  final Rx<CountryEntity> _country = CountryModel().toDomain().obs;
  final RxBool _loadingRoom = false.obs;
  final RxBool _loadingRoomPagination = false.obs;
  final RxList<RoomEntity> _rooms = <RoomEntity>[].obs;
  final Rx<PaginationEntity> _pagination = PaginationModel().toDomain().obs;
  int page = 1;

  CountryEntity get country => _country.value;
  bool get loadingRoom => _loadingRoom.value;
  bool get loadingRoomPagination => _loadingRoomPagination.value;
  List<RoomEntity> get rooms => _rooms;
  PaginationEntity get pagination => _pagination.value;

  set country(CountryEntity value) => _country.value = value;
  set loadingRoom(value) => _loadingRoom.value = value;
  set loadingRoomPagination(value) => _loadingRoomPagination.value = value;
  set rooms(List<RoomEntity> value) => _rooms.value = value;
  set pagination(PaginationEntity value) => _pagination.value = value;

  getRoom({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingRoomPagination = true;
    } else {
      loadingRoom = true;
      rooms.clear();
      page = 1;
    }
    (await _byCountryIdUseCase.execute({
      "id": country.id,
      "page": page,
    }))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        rooms.addAll(r.data);
        pagination = r.pagination;
        page++;
      },
    );
    loadingRoom = false;
    loadingRoomPagination = false;
  }

  @override
  void onInit() async {
    country = Get.arguments ?? CountryModel().toDomain();
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (pagination.nextPageUrl.isNotEmpty && !loadingRoomPagination) {
          await getRoom(isPaginate: true);
        }
      }
    });
    await getRoom();
    super.onInit();
  }
}
