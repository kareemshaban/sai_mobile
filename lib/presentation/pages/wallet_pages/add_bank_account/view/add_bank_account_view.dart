import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/address_pages/add_new_address/widget/address_form_field.dart';
import 'package:new_sai/presentation/pages/wallet_pages/add_bank_account/getx/add_bank_account_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class AddBankAccountView extends GetView<AddBankAccountController> {
  const AddBankAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.addBankAccount),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  10.verticalSpace(),
                  AddressFormField(
                    title: AppStrings.fullName,
                    hint: AppStrings.firstAndLastName,
                    validator: AppValidation.validateEmpty,
                    controller: controller.userNameTextController,
                  ),
                  30.verticalSpace(),
                  AddressFormField(
                    controller: controller.bankNumberTextController,
                    title: AppStrings.internationalBankAccountNumber,
                    validator: AppValidation.validateEmpty,
                    // type: TextInputType.number,
                  ),
                  30.verticalSpace(),
                  AddressFormField(
                    controller: controller.bankNameTextCotnroller,
                    title: AppStrings.bankName,
                    validator: AppValidation.validateEmpty,
                  ),
                  // 30.verticalSpace(),
                  // AddressFormField(
                  //   title: AppStrings.registeredPhoneNumber,
                  //   validator: AppValidation.validateEmpty,
                  //   hint: "12345678",
                  // ),
                  30.verticalSpace(),
                  AddressFormField(
                    controller: controller.countyNameTextController,
                    title: AppStrings.country,
                    validator: AppValidation.validateEmpty,
                  ),
                ],
              ),
            ).toSliver(),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Obx(() {
                        return Checkbox(
                          value: controller.acceptTerms,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          onChanged: controller.changeAcceptTemsValue,
                        );
                      }),
                      6.horizontalSpace(),
                      Flexible(
                        child: Text(
                          AppStrings
                              .iPledgeThatTheInformationIsCorrectAndIWillBeResponsibleForAnyCosts,
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontSize: AppSize.s13(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  30.verticalSpace(),
                  Obx(() {
                    return controller.isLoading
                        ? const Center(
                            child: AppLoader(),
                          )
                        : AppButton(
                            title: AppStrings.send,
                            width: .7.w(context),
                            onTap: controller.sendWithdrawRequest,
                          );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
