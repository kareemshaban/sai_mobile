import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/params/settings_params/change_privacy_params.dart';
import 'package:new_sai/domain/use_case/settings_use_case/change_privacy_use_case.dart';

class PrivacyController extends GetxController {
  final appController = Get.find<AppController>();
  final ChangePrivacyUseCase _changePrivacyUseCase =
      instance<ChangePrivacyUseCase>();

  final RxString _profileValue = ''.obs;
  final RxString _trackValue = ''.obs;
  final RxString _messagesValue = ''.obs;
  final RxString _storyValue = ''.obs;

  String get profileValue => _profileValue.value;
  String get trackValue => _trackValue.value;
  String get messagesValue => _messagesValue.value;
  String get storyValue => _storyValue.value;

  set profileValue(value) => _profileValue.value = value;
  set trackValue(value) => _trackValue.value = value;
  set messagesValue(value) => _messagesValue.value = value;
  set storyValue(value) => _storyValue.value = value;

  Future<bool> changePrivacy(String type, String value) async {
    Get.back();
    final params = ChangePrivacyParams(
      type: type,
      value: value,
    );
    return (await _changePrivacyUseCase.execute(params)).fold(
      (l) {
        return false;
      },
      (r) {
        print(type);
        print(value);
        return true;
      },
    );
  }

  @override
  void onInit() {
    profileValue = appController.user.profile;
    trackValue = appController.user.track;
    messagesValue = appController.user.comment;
    storyValue = appController.user.story;
    super.onInit();
  }
}
