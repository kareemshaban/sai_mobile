import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/address_pages/add_new_address/getx/add_new_address_controller.dart';
import 'package:new_sai/presentation/pages/address_pages/add_new_address/widget/address_form_field.dart';
import 'package:new_sai/presentation/pages/address_pages/add_new_address/widget/delete_address_dialog.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class AddNewAddressView extends GetView<AddNewAddressController> {
  const AddNewAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        leadingWidth: 60,
        title: Text(
            controller.isEdit ? AppStrings.editAddress : AppStrings.addAddress),
        actions: [
          if (controller.isEdit) ...[
            InkWell(
              onTap: () => Get.dialog(
                const DeleteAddressDialog(),
                barrierDismissible: false,
              ),
              child: const AppIcon(
                icon: IconsAssets.delete,
                color: ColorManager.appRedColor,
                width: 25,
                height: 25,
              ),
            ),
            16.horizontalSpace(),
          ],
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 22,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddressFormField(
                  title: AppStrings.fullName,
                  hint: AppStrings.firstAndLastName,
                  controller: controller.nameController,
                  validator: AppValidation.validateEmpty,
                ),
                30.verticalSpace(),
                AddressFormField(
                  title: AppStrings.street,
                  hint: AppStrings.enterTheNameOfTheStreetOrUnit,
                  controller: controller.streetController,
                ),
                AddressFormField(
                  hint: AppStrings.nearALandmarkOptional,
                  controller: controller.streetMarkController,
                ),
                30.verticalSpace(),
                AddressFormField(
                  title: AppStrings.countyAndCity,
                  hint: AppStrings.selectTheArea,
                  controller: controller.countryController,
                  readOnly: true,
                  onTap: controller.onTapCountry,
                  validator: AppValidation.validateEmpty,
                  suffix: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: ColorManager.iconGreyColor,
                  ),
                ),
                30.verticalSpace(),
                AddressFormField(
                  title: AppStrings.mobileNumber,
                  hint: AppStrings.mobileNumber,
                  controller: controller.phoneController,
                  validator: AppValidation.validateEmpty,
                  type: TextInputType.phone,
                ),
                AddressFormField(
                  hint: AppStrings.alternatePhoneNumberOptional,
                  controller: controller.optionalPhoneController,
                  type: TextInputType.phone,
                ),
                30.verticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.setAsDefault,
                      style: Get.textTheme.titleSmall!.copyWith(
                        fontSize: AppSize.s20(context),
                      ),
                    ),
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: Checkbox(
                        value: controller.isDefault,
                        onChanged: controller.onChangeIsDefault,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
          child: controller.loading
              ? const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(child: AppLoader()),
                  ],
                )
              : AppButton(
                  title: controller.isEdit
                      ? AppStrings.editAddress
                      : AppStrings.addAddress,
                  onTap: controller.onTapSendButton,
                  width: 1.w(context),
                ),
        ),
      ),
    );
  }
}
