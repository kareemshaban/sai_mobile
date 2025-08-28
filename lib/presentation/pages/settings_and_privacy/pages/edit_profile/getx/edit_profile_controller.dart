import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/country_model.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/update_profile_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class EditProfileController extends GetxController {
  final appController = Get.find<AppController>();
  final UpdateProfileUseCase _updateProfileUseCase =
      instance<UpdateProfileUseCase>();

  final RxString _coverImagePath = ''.obs;
  final RxString _imagePath = ''.obs;
  final RxString _gender = ''.obs;
  final RxString _name = ''.obs;
  final RxString _bio = ''.obs;
  final RxString _date = ''.obs;
  final Rx<CountryEntity> _country = CountryModel().toDomain().obs;
  final RxBool _loading = false.obs;

  String get coverImagePath => _coverImagePath.value;
  String get imagePath => _imagePath.value;
  String get gender => _gender.value;
  String get name => _name.value;
  String get bio => _bio.value;
  String get date => _date.value;
  CountryEntity get country => _country.value;
  bool get loading => _loading.value;

  set coverImagePath(value) => _coverImagePath.value = value;
  set imagePath(value) => _imagePath.value = value;
  set gender(value) => _gender.value = value;
  set name(value) => _name.value = value;
  set bio(value) => _bio.value = value;
  set date(value) => _date.value = value;
  set country(CountryEntity value) => _country.value = value;
  set loading(value) => _loading.value = value;

  pickCoverImage() async {
    if (appController.vipActive &&
        appController.user.privileges.data.profileCover.id == 0) {
      showSnackBarWidget(
          message: AppStrings.youCannotAddACoverUntilYouBecomeAPremiumUser);
      return;
    }
    coverImagePath = await pickImage() ?? "";
  }

  pickProfileImage() async {
    imagePath = await pickImage() ?? "";
  }

  onTapCountryButton() async {
    final c = await Get.toNamed(AppRoutes.countryListRoute);
    if (c != null) {
      country = c;
    }
  }

  onTapGender(String value) {
    gender = value;
  }

  updateProfile() async {
    if (loading) {
      return;
    }
    loading = true;
    final params = AuthParams(
      name: name,
      gender: gender == AppStrings.male ? "male" : "female",
      birthDate: date,
      countryId: country.id,
      profileImg: imagePath.isNotEmpty ? imagePath : null,
      profileCover: coverImagePath.isNotEmpty ? coverImagePath : null,
      profileDescription: bio,
    );
    (await _updateProfileUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        print('test123123123123');
        print(imagePath);
        print(r.profileImg.toString());
        
        Get.find<AppController>().getUser();
        
        Get.find<ProfileController>().getMyProfile();
        Get.back();
      },
    );
    loading = false;
  }

  @override
  void onInit() {
    name = appController.user.name;
    bio = appController.user.profileDescription;
    date = appController.user.birthDate;
    gender = appController.user.gender;
    country = appController.user.country;
    super.onInit();
  }
}
