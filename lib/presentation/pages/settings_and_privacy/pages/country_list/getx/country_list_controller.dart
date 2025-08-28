import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/domain/use_case/app_use_case/get_country_list_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class CountryListController extends GetxController {
  final GetCountryListUseCase _countryListUseCase =
      instance<GetCountryListUseCase>();
  final RxBool _loading = false.obs;
  final RxList<CountryEntity> _commonCountry = <CountryEntity>[].obs;
  final RxList<CountryEntity> _allCountry = <CountryEntity>[].obs;

  bool get loading => _loading.value;
  List<CountryEntity> get commonCountry => _commonCountry;
  List<CountryEntity> get allCountry => _allCountry;

  set loading(value) => _loading.value = value;
  set commonCountry(List<CountryEntity> value) => _commonCountry.value = value;
  set allCountry(List<CountryEntity> value) => _allCountry.value = value;

  getCountryList() async {
    commonCountry.clear();
    allCountry.clear();
    loading = true;
    (await _countryListUseCase.execute('')).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        for (var element in r) {
          if (element.isFamous == 1) {
            commonCountry.add(element);
          } else {
            allCountry.add(element);
          }
        }
      },
    );
    loading = false;
  }

  @override
  void onInit() async {
    await getCountryList();
    super.onInit();
  }
}
