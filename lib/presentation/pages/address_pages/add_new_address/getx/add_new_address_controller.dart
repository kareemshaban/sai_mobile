import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/model/app_model/country_model.dart';
import 'package:new_sai/data/model/store_model/address_model.dart';
import 'package:new_sai/data/params/store_params/address_params.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/domain/entity/store_entity/address_entity.dart';
import 'package:new_sai/domain/use_case/store_use_case/add_address_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/delete_address_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/update_address_use_case.dart';
import 'package:new_sai/presentation/pages/address_pages/address/getx/address_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/getx/confirm_order_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class AddNewAddressController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final streetController = TextEditingController();
  final streetMarkController = TextEditingController();
  final phoneController = TextEditingController();
  final optionalPhoneController = TextEditingController();
  final countryController = TextEditingController();
  final AddAddressUseCase _addAddressUseCase = instance<AddAddressUseCase>();
  final UpdateAddressUseCase _updateAddressUseCase =
      instance<UpdateAddressUseCase>();
  final DeleteAddressUseCase _deleteAddressUseCase =
      instance<DeleteAddressUseCase>();
  final addressController = Get.find<AddressController>();
  bool isEdit = false;
  AddressEntity address = AddressModel().toDomain();

  final Rx<CountryEntity> _country = CountryModel().toDomain().obs;
  final RxBool _isDefault = false.obs;
  final RxBool _loading = false.obs;
  final RxBool _loadingDelete = false.obs;

  CountryEntity get country => _country.value;
  bool get isDefault => _isDefault.value;
  bool get loading => _loading.value;
  bool get loadingDelete => _loadingDelete.value;

  set country(CountryEntity value) => _country.value = value;
  set isDefault(value) => _isDefault.value = value;
  set loading(value) => _loading.value = value;
  set loadingDelete(value) => _loadingDelete.value = value;

  addAddress(AddressParams params) async {
    (await _addAddressUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        addressController.getMyAddress();
        Get.back();
        if (Get.currentRoute == AppRoutes.confirmOrderRoute) {
          Get.find<ConfirmOrderController>().getDeliveryPrice();
        }
      },
    );
  }

  updateAddress(AddressParams params) async {
    (await _updateAddressUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        addressController.getMyAddress();
        Get.back();
      },
    );
  }

  onTapSendButton() async {
    if (loading) return;
    if (formKey.currentState!.validate()) {
      loading = true;
      final params = AddressParams(
        fullName: nameController.text,
        countryId: country.id,
        phone: phoneController.text,
        streetMark: streetMarkController.text.isEmpty
            ? null
            : streetMarkController.text,
        optionalPhone: optionalPhoneController.text.isEmpty
            ? null
            : optionalPhoneController.text,
        isDefault: isDefault ? 1 : 0,
        id: address.id != 0 ? address.id : null,
        street: streetController.text.isEmpty ? null : streetController.text,
      );
      if (isEdit) {
        await updateAddress(params);
      } else {
        await addAddress(params);
      }
      loading = false;
    }
  }

  onChangeIsDefault(value) {
    isDefault = value;
  }

  onTapCountry() async {
    final c = await Get.toNamed(AppRoutes.countryListRoute);
    if (c != null) {
      country = c;
      countryController.text = country.name;
    }
  }

  deleteAddress() async {
    if (loadingDelete) return;
    loadingDelete = true;
    (await _deleteAddressUseCase.execute(address.id)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        Get.until((route) {
          if (Get.currentRoute == AppRoutes.addressRoute) {
            return true;
          }
          return false;
        });
        addressController.getMyAddress();
      },
    );
    loadingDelete = false;
  }

  @override
  void onInit() {
    isEdit = Get.arguments['isEdit'] ?? false;
    address = Get.arguments['address'] ?? AddressModel().toDomain();
    if (isEdit) {
      nameController.text = address.fullName;
      streetController.text = address.street;
      streetMarkController.text = address.streetMark;
      phoneController.text = address.phone;
      optionalPhoneController.text = address.optionalPhone;
      countryController.text = address.country.name;
      country = address.country;
      isDefault = address.isDefault;
    }
    super.onInit();
  }
}
