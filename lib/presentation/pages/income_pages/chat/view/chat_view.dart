import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/presentation/pages/income_pages/chat/getx/chat_controller.dart';
import 'package:new_sai/presentation/pages/income_pages/chat/widgets/chat_bottom_bar_widget.dart';
import 'package:new_sai/presentation/pages/income_pages/chat/widgets/chat_messages_list.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: InkWell(
          onTap: () => Get.toNamed(
            AppRoutes.userProfileRoute,
            arguments: {
              'id': controller.recID,
              'isFromChat': true,
            },
          ),
          child: Text(controller.user.name),
        ),
        actions: [
          InkWell(
            onTap: () => Get.toNamed(
              AppRoutes.userProfileRoute,
              arguments: {
                'id': controller.recID,
                'isFromChat': true,
              },
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(
                controller.user.logo,
                fit: BoxFit.cover,
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) => const AppImage(
                  image: Constants.userErrorWidget,
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                  isCircle: true,
                ),
              ),
            ),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: controller.deleteChat,
                  child: Text(
                    AppStrings.deleteChat,
                  ),
                ),
              ];
            },
            position: PopupMenuPosition.under,
          ),
        ],
      ),
      body: const ChatMessagesList(),
      bottomSheet: const ChatBottomBarWidget(),
    );
  }
}
