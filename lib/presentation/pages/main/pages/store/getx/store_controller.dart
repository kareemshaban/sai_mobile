import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/model/store_model/home_model.dart';
import 'package:new_sai/domain/entity/store_entity/home_entity.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_home_data_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class StoreController extends GetxController {
  final GetHomeDataUseCase _getHomeDataUseCase = instance<GetHomeDataUseCase>();
  final RxBool _loadingHomeData = false.obs;
  final Rx<HomeEntity> _homeData = HomeModel().toDomain().obs;

  HomeEntity get homeData => _homeData.value;
  bool get loadingHomeData => _loadingHomeData.value;

  set homeData(HomeEntity value) => _homeData.value = value;
  set loadingHomeData(value) => _loadingHomeData.value = value;

  getHomeData() async {
    loadingHomeData = true;
    (await _getHomeDataUseCase.execute('')).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        homeData = r;
      },
    );
    loadingHomeData = false;
  }

  onTapFavorite(int index) async {
    final lastStatus = homeData.products[index].isMyFavorite == 1;
    homeData.products[index].isMyFavorite = lastStatus ? 0 : 1;
    _homeData.refresh();
    bool success = await addRemoveFavorite(
      homeData.products[index].id,
    );

    if (success) {
      if (lastStatus) {
        homeData.products[index].isMyFavorite = 0;
      } else {
        homeData.products[index].isMyFavorite = 1;
      }
    } else {
      homeData.products[index].isMyFavorite = lastStatus ? 1 : 0;
    }
    _homeData.refresh();
  }

  @override
  void onInit() async {
    await getHomeData();
    super.onInit();
  }
}
