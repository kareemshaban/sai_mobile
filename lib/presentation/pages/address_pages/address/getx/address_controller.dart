import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/model/store_model/address_model.dart';
import 'package:new_sai/domain/entity/store_entity/address_entity.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_my_addresses_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class AddressController extends GetxController {
  final GetMyAddressesUseCase _addressesUseCase =
      instance<GetMyAddressesUseCase>();

  final Rx<AddressEntity> _selectedAddress = AddressModel().toDomain().obs;
  final RxBool _loading = false.obs;
  final RxList<AddressEntity> _addresses = <AddressEntity>[].obs;

  AddressEntity get selectedAddress => _selectedAddress.value;
  bool get loading => _loading.value;
  List<AddressEntity> get addresses => _addresses;

  set selectedAddress(AddressEntity value) => _selectedAddress.value = value;
  set loading(value) => _loading.value = value;
  set addresses(List<AddressEntity> value) => _addresses.value = value;

  getMyAddress() async {
    loading = true;
    addresses.clear();
    selectedAddress = AddressModel().toDomain();
    (await _addressesUseCase.execute('')).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        addresses = r;
        for (var element in addresses) {
          if (element.isDefault) {
            selectedAddress = element;
          }
        }
      },
    );
    loading = false;
  }

  @override
  void onInit() async {
    if (!isGuest()) {
      await getMyAddress();
    }
    super.onInit();
  }
}
