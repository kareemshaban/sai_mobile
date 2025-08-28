import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

import 'user_raise_hand_widget.dart';

class RaiseHandRequestBottomSheet extends GetView<RoomController> {
  const RaiseHandRequestBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      height: 0.45.h(context),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: const BoxDecoration(
          color: ColorManager.scaffoldBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.raiseHandRequest,
            style: context.textTheme.labelLarge,
          ),
          20.verticalSpace(),
          Expanded(
            child: Obx(
              () => controller.requestMicList.isEmpty
                  ? Center(
                      child: Text(
                        AppStrings.noDataFound,
                        style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: AppSize.s20(context),
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) => UserRaiseHandWidget(
                        model: controller.requestMicList[index],
                        onTapApprove: () => controller.approveSpeakToMic(
                            controller.requestMicList[index].userID),
                        onTapReject: () => controller.rejectSpeakToMic(
                            controller.requestMicList[index].userID),
                      ),
                      separatorBuilder: (context, index) => 10.verticalSpace(),
                      itemCount: controller.requestMicList.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
