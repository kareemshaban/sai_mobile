import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/country_model.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/update_profile_use_case.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ProfileDataController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final countryController = TextEditingController();
  final appController = Get.find<AppController>();
  final UpdateProfileUseCase _updateProfileUseCase =
      instance<UpdateProfileUseCase>();
  final RxString _imagePath = "".obs;
  final RxString _gender = "".obs;
  final RxBool _loading = false.obs;
  final Rx<CountryEntity> _country = CountryModel().toDomain().obs;

  String get imagePath => _imagePath.value;
  String get gender => _gender.value;
  bool get loading => _loading.value;
  CountryEntity get country => _country.value;

  set imagePath(value) => _imagePath.value = value;
  set gender(value) => _gender.value = value;
  set loading(value) => _loading.value = value;
  set country(CountryEntity value) => _country.value = value;

  onPickImage() async {
    imagePath = await pickImage();
  }

  onTapGender(String value) {
    gender = value;
  }

  onTapCountry() async {
    final c = await Get.toNamed(AppRoutes.countryListRoute);
    if (c != null) {
      country = c;
      countryController.text = c.name;
    }
  }

  updateProfile() async {
    if (loading) {
      return;
    }
    if (formKey.currentState!.validate()) {
      loading = true;
      final params = AuthParams(
        name: nameController.text.isNotEmpty ? nameController.text : null,
        birthDate: dateController.text.isNotEmpty ? dateController.text : null,
        countryId: country.id != 0 ? country.id : null,
        gender: gender.isNotEmpty ? gender : null,
        profileImg: imagePath.isNotEmpty ? imagePath : null,
      );
      (await _updateProfileUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) {
          appController.saveUser(r);
          Get.offAllNamed(AppRoutes.mainRoute);
        },
      );
      loading = false;
    }
  }
}
