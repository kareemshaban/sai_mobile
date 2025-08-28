import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/room_mapper.dart';
import 'package:new_sai/data/model/room_model/room_settings_model.dart';
import 'package:new_sai/data/params/room_params/fire_user_params.dart';
import 'package:new_sai/data/params/room_params/update_room_settings_params.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_settings_entity.dart';
import 'package:new_sai/domain/use_case/room_use_case/cancel_fire_user_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_fire_user_list_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_settings_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/update_room_settings_use_case.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_update_settings_model.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class RoomSettingsController extends GetxController {
  String roomID = '';
  final roomController = Get.find<RoomController>();
  final GetRoomSettingsUseCase _getRoomSettingsUseCase =
      instance<GetRoomSettingsUseCase>();
  final UpdateRoomSettingsUseCase _updateRoomSettingsUseCase =
      instance<UpdateRoomSettingsUseCase>();
  final GetFireUserListUseCase _fireUserListUseCase =
      instance<GetFireUserListUseCase>();
  final CancelFireUserUseCase _cancelFireUserUseCase =
      instance<CancelFireUserUseCase>();
  final RxBool _loadingGetSettings = false.obs;
  final Rx<RoomSettingsEntity> _settings = RoomSettingsModel().toDomain().obs;
  final RxList<UserEntity> _firedUsersList = <UserEntity>[].obs;
  final RxString _imagePath = ''.obs;
  final RxString _roomName = ''.obs;
  final RxString _roomNotification = ''.obs;
  final RxString _membershipFee = ''.obs;
  final RxInt _micCount = 7.obs;
  final RxBool _loadingGetFireList = false.obs;
  final RxBool _loadingCancelFire = false.obs;

  bool get loadingGetSettings => _loadingGetSettings.value;
  RoomSettingsEntity get settings => _settings.value;
  List<UserEntity> get firedUsersList => _firedUsersList;
  String get imagePath => _imagePath.value;
  String get roomName => _roomName.value;
  String get roomNotification => _roomNotification.value;
  String get membershipFee => _membershipFee.value;
  int get micCount => _micCount.value;
  bool get loadingGetFireList => _loadingGetFireList.value;
  bool get loadingCancelFire => _loadingCancelFire.value;

  set loadingGetSettings(value) => _loadingGetSettings.value = value;
  set settings(RoomSettingsEntity value) => _settings.value = value;
  set firedUsersList(List<UserEntity> value) => _firedUsersList.value = value;
  set imagePath(value) => _imagePath.value = value;
  set roomName(value) => _roomName.value = value;
  set roomNotification(value) => _roomNotification.value = value;
  set membershipFee(value) => _membershipFee.value = value;
  set micCount(value) => _micCount.value = value;
  set loadingGetFireList(value) => _loadingGetFireList.value = value;
  set loadingCancelFire(value) => _loadingCancelFire.value = value;

  getRoomSettings() async {
    loadingGetSettings = true;
    (await _getRoomSettingsUseCase.execute(roomID)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        settings = r;
        roomName = settings.roomName;
        roomNotification = settings.notificationContent;
        membershipFee = settings.membershipFee.toString();
        micCount = settings.microphonesCount.toInt();
      },
    );
    loadingGetSettings = false;
  }

  onPickRoomImage() async {
    imagePath = await pickImage() ?? '';
  }

  upadteSettings() async {
    showAppLoadingDialog();
    final params = UpdateRoomSettingsParams(
      roomID: roomID,
      profileImage: imagePath.isNotEmpty ? imagePath : null,
      roomName: roomName,
      notificationContent: roomNotification,
      membershipFee: num.parse(membershipFee),
      microphonesCount: micCount,
    );
    (await _updateRoomSettingsUseCase.execute(params)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        roomController.updateRoomSettings(RoomUpdateSettingsModel(
          roomName: r.roomName,
          roomNotification: r.generalNotificationContent,
          roomImage: r.roomImage,
          roomMemperFee: r.membershipFee,
          roomMicsCount: r.microphonesCount,
        ));
        Get.until(
          (route) {
            if (Get.currentRoute == AppRoutes.roomRoute) {
              return true;
            }
            return false;
          },
        );
      },
    );
  }

  getFireList() async {
    loadingGetFireList = true;
    firedUsersList.clear();
    (await _fireUserListUseCase.execute(roomID)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        firedUsersList = r;
      },
    );
    loadingGetFireList = false;
  }

  cancelFire(String userID) async {
    if (loadingCancelFire) return;
    loadingCancelFire = true;
    final params = FireUserParams(
      roomID: roomID,
      userID: userID,
    );
    (await _cancelFireUserUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        await getFireList();
      },
    );
    loadingCancelFire = false;
  }

  @override
  void onInit() async {
    roomID = Get.arguments;
    await getRoomSettings();
    await getFireList();
    super.onInit();
  }
}
