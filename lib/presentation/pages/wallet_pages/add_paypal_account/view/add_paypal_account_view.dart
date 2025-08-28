import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/address_pages/add_new_address/widget/address_form_field.dart';
import 'package:new_sai/presentation/pages/wallet_pages/add_paypal_account/getx/add_paypal_account_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class AddPaypalAccountView extends GetView<AddPaypalAccountController> {
  const AddPaypalAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.addPaypalAccount),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: [
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  AddressFormField(
                    controller: controller.userNameTextController,
                    title: AppStrings.fullName,
                    hint: AppStrings.firstAndLastName,
                    validator: AppValidation.validateEmpty,
                  ),
                  25.verticalSpace(),
                  // AddressFormField(
                  //   title: AppStrings.yourPaypalAccountEmail,
                  //   hint: "test@gmail.com",
                  // ),
                  AddressFormField(
                    controller: controller.payPalIdTextCotnroller,
                    title: AppStrings.payPalId,
                    validator: AppValidation.validateEmpty,
                  ),
                  25.verticalSpace(),
                  AddressFormField(
                    controller: controller.confirmPayPalIdTextCotnroller,
                    title: AppStrings.confirmPayPalId,
                    validator: AppValidation.validateEmpty,
                  ),
                  25.verticalSpace(),
                  AddressFormField(
                    controller: controller.countryTextController,
                    title: AppStrings.country,
                    validator: AppValidation.validateEmpty,
                  ),
                ],
              ),
            ).toSliver(),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Obx(() => Checkbox(
                            value: controller.acceptTerms,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            onChanged: controller.chanveAcceptTemsValue,
                          )),
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
                  Obx(() => controller.isLoading
                      ? const Center(
                          child: AppLoader(),
                        )
                      : AppButton(
                          title: AppStrings.send,
                          width: .7.w(context),
                          onTap: controller.withdrawRequest,
                        )),
                  10.verticalSpace(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
