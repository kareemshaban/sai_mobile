import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_gift_users_entity.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_gift_users_use_case.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class MyThemesBottomSheet extends  GetView<RoomController> {
  final String roomID;

  const MyThemesBottomSheet({super.key, required this.roomID});


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
            AppStrings.roomTheme,
            style: context.textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

}