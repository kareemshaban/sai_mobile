import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/create_room/getx/create_room_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class CreateRoomView extends GetView<CreateRoomController> {
  const CreateRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.createMyRoom),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Obx(
                () => InkWell(
                  onTap: controller.pickRoomImage,
                  child: Container(
                    width: 128,
                    height: 103,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 29),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.lightGreyColor.withOpacity(.4),
                      image: controller.image.isNotEmpty
                          ? DecorationImage(
                              image: FileImage(File(controller.image)),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage(ImageAssets.camera),
                            ),
                    ),
                  ),
                ),
              ),
              40.verticalSpace(),
              AppFormFiled(
                label: AppStrings.roomName,
                hint: AppStrings.namingYourRoom,
                borderColor: ColorManager.transparent,
                controller: controller.roomNameController,
                validator: AppValidation.validateEmpty,
              ),
              17.verticalSpace(),
              AppFormFiled(
                label: AppStrings.generalNotification,
                hint: AppStrings.yourRoomNotification,
                borderColor: ColorManager.transparent,
                controller: controller.roomNotificationController,
                validator: AppValidation.validateEmpty,
              ),
              60.verticalSpace(),
              Obx(
                () => controller.loading
                    ? const Center(child: AppLoader())
                    : AppButton(
                        title: AppStrings.createRoom,
                        width: .7.w(context),
                        onTap: controller.createRoom,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
