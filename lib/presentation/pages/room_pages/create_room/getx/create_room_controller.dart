import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/params/room_params/create_room_params.dart';
import 'package:new_sai/domain/use_case/room_use_case/create_room_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/getx/rooms_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:x_overlay/x_overlay.dart';

class CreateRoomController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final roomNameController = TextEditingController();
  final roomNotificationController = TextEditingController(
    text: AppStrings.helloEveryoneLetsTalkAndHaveFunTogether,
  );

  final CreateRoomUseCase _createRoomUseCase = instance<CreateRoomUseCase>();

  final RxBool _loading = false.obs;
  final RxString _image = ''.obs;

  bool get loading => _loading.value;
  String get image => _image.value;

  set loading(value) => _loading.value = value;
  set image(value) => _image.value = value;

  pickRoomImage() async {
    image = await pickImage() ?? "";
  }

  createRoom() async {
    if (loading) return;
    if (formKey.currentState!.validate()) {
      final params = CreateRoomParams(
        generalNotificationContent: roomNotificationController.text.isNotEmpty
            ? roomNotificationController.text
            : null,
        roomImage: image.isNotEmpty ? image : null,
        roomName:
            roomNameController.text.isNotEmpty ? roomNameController.text : null,
      );
      loading = true;
      (await _createRoomUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) async {
          if (Get.isRegistered<RoomController>()) {
            final roomController = Get.find<RoomController>();
            if (AppRoutes.overlayController.pageStateNotifier.value ==
                XOverlayPageState.overlaying) {
              AppRoutes.overlayController.hide();
              await roomController.closeAndDisposeRoom();
            }

            roomController.initController(
              r.id.toString(),
              data: {
                "roomName": r.roomName,
                "referenceId": r.roomReferenceId,
                "backgroundTheme": r.backgroundTheme,
                "roomImage": r.roomImage,
              },
            );
          }
          Get.offNamed(AppRoutes.roomRoute, arguments: {
            "id": r.id.toString(),
            "data": {
              "roomName": r.roomName,
              "referenceId": r.roomReferenceId,
              "backgroundTheme": r.backgroundTheme,
              "roomImage": r.roomImage,
            },
          });
          Get.find<RoomsController>().getMyOwnPage();
        },
      );
      loading = false;
    }
  }
}
