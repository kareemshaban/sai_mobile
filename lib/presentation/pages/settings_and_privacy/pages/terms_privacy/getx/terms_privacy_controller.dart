import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/settings_mapper.dart';
import 'package:new_sai/data/model/settings_model/terms_privacy_model.dart';
import 'package:new_sai/domain/entity/settings_entity/terms_privacy_entity.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_terms_privacy_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class TermsPrivacyController extends GetxController {
  late int type;
  final GetTermsPrivacyUseCase _getTermsPrivacyUseCase =
      instance<GetTermsPrivacyUseCase>();

  final RxBool _loading = false.obs;
  final Rx<TermsPrivacyEntity> _data = TermsPrivacyModel().toDomain().obs;

  bool get loading => _loading.value;
  TermsPrivacyEntity get data => _data.value;

  set loading(value) => _loading.value = value;
  set data(TermsPrivacyEntity value) => _data.value = value;

  getTerms() async {
    loading = true;
    (await _getTermsPrivacyUseCase.execute(type)).fold(
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
  void onInit() async {
    type = Get.arguments;
    await getTerms();
    super.onInit();
  }
}
