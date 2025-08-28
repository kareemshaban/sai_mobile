import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/income_pages/chat/getx/chat_controller.dart';
import 'package:new_sai/presentation/pages/income_pages/chat/widgets/file_message_widget.dart';
import 'package:new_sai/presentation/pages/income_pages/chat/widgets/image_message_widget.dart';
import 'package:new_sai/presentation/pages/income_pages/chat/widgets/voice_message_widget.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'message_widget.dart';

class ChatMessagesList extends StatefulWidget {
  const ChatMessagesList({super.key});

  @override
  State<ChatMessagesList> createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends State<ChatMessagesList>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => controller.loadingMessages
          ? const Center(child: AppLoader())
          : Column(
              children: [
                if (controller.loadingMessagesPagination)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: AppLoader()),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: ListView.separated(
                      key: const PageStorageKey('chat_messages_list_key'),
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: controller.scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      reverse: true,
                      itemBuilder: (context, index) {
                        if (controller.messages[index].type == 'text') {
                          return MessageWidget(
                            isSender: controller.messages[index].fromId ==
                                controller.appController.user.id,
                            model: controller.messages[index],
                          );
                        } else if (controller.messages[index].type == 'image') {
                          return ImageMessageWidget(
                            isSender: controller.messages[index].fromId ==
                                controller.appController.user.id,
                            model: controller.messages[index],
                          );
                        } else if (controller.messages[index].type == 'file') {
                          return FileMessageWidget(
                            isSender: controller.messages[index].fromId ==
                                controller.appController.user.id,
                            model: controller.messages[index],
                          );
                        }
                        return VoiceMessageWidget(
                          key: ValueKey(controller.messages[index].id),
                          isSender: controller.messages[index].fromId ==
                              controller.appController.user.id,
                          model: controller.messages[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return 20.verticalSpace();
                      },
                      itemCount: controller.messages.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
