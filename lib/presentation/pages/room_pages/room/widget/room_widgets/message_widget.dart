import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/message_widget_model.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

import 'room_image_view.dart';

class MessageWidget extends StatelessWidget {
  final MessageWidgetModel message;
  final void Function() onConfirmDelete;
  const MessageWidget(
      {super.key, required this.message, required this.onConfirmDelete});

  @override
  Widget build(BuildContext context) {
    if (context.locale == arabicLocale) {
      return SlideInRight(
        duration: const Duration(milliseconds: 300),
        child: messageWidget(context),
      );
    }
    return SlideInLeft(
      duration: const Duration(milliseconds: 300),
      child: messageWidget(context),
    );
  }

  Widget messageWidget(BuildContext context) {
    final roomController = Get.find<RoomController>();

    return Obx(
      () {
        final user = roomController.apiUsers.firstWhereOrNull(
            (element) => element.id.toString() == message.user.userID);
        return Dismissible(
          key: ValueKey(message.user.userID),
          background: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.reply,
                  color: ColorManager.white,
                  size: 20,
                ),
              ],
            ),
          ),
          direction: message.user.userID ==
                  roomController.appController.user.id.toString()
              ? DismissDirection.none
              : DismissDirection.startToEnd,
          dismissThresholds: const {
            DismissDirection.startToEnd: .2,
          },
          confirmDismiss: (direction) async {
            onConfirmDelete();
            return false;
          },
          child: Container(
            constraints: BoxConstraints(
              maxWidth: .75.w(context),
            ),
            margin: const EdgeInsets.only(bottom: 9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    roomController.openProfileBottomSheet(message.user.userID);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          roomController.getUserImage(message.user.userID),
                          errorBuilder: (context, error, stackTrace) {
                            return roomController.userErrorImageWidget(
                              width: 40,
                              height: 40,
                            );
                          },
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (user != null)
                        PrivilegeDataView(
                          url: user.privileges.data.profileFrame.file,
                          width: 40,
                          height: 40,
                        )
                    ],
                  ),
                ),
                3.horizontalSpace(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          roomController
                              .openProfileBottomSheet(message.user.userID);
                        },
                        child: Row(
                          children: [
                            
                            Flexible(
                              child: Text(
                                message.user.userName,
                                style: Get.textTheme.bodySmall!.copyWith(
                                  fontSize: AppSize.s16(context),
                                  color: Get.find<AppController>().isVipActive()
                                      ? user != null &&
                                              user.privileges.data.colorfulName
                                                  .value.isNotEmpty
                                          ? Colors.white.fromHex(user.privileges
                                              .data.colorfulName.value)
                                          : null
                                      : null,
                                ),
                              ),
                            ),
                            if (user != null && user.badges.isNotEmpty) ...[
                              2.horizontalSpace(),
                              PrivilegeDataView(
                                isBadges: true,
                                url: user.badges.first,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (message.message != null &&
                          message.message!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorManager.black.withOpacity(.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Linkify(
                            text: message.message!,
                            style: Get.textTheme.bodySmall!.copyWith(
                              fontSize: AppSize.s16(context),
                            ),
                            linkStyle: Get.textTheme.bodyLarge!.copyWith(
                              fontSize: AppSize.s16(context),
                            ),
                            linkifiers: const [
                              UserTagLinkifier(),
                            ],
                          ),
                        ),
                      if (message.image != null) ...[
                        5.verticalSpace(),
                        InkWell(
                          onTap: () {
                            Get.dialog(RoomImageView(image: message.image!));
                          },
                          child: AppImage(
                            image: message.image!,
                            width: 180,
                            height: 180,
                            radius: 8,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserTagLinkifier extends Linkifier {
  const UserTagLinkifier();

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];

    for (var element in elements) {
      if (element is TextElement) {
        var match = _userTagRegex.firstMatch(element.text);

        if (match == null) {
          list.add(element);
        } else {
          var textElement = '';
          var text = element.text.replaceFirst(match.group(0)!, '');
          while (match?.group(1)?.contains(RegExp(r'[\w@]$')) == true) {
            textElement += match!.group(0)!;
            match = _userTagRegex.firstMatch(text);
            if (match == null) {
              textElement += text;
              text = '';
            } else {
              text = text.replaceFirst(match.group(0)!, '');
            }
          }

          if (textElement.isNotEmpty || match?.group(1)?.isNotEmpty == true) {
            list.add(TextElement(textElement + (match?.group(1) ?? '')));
          }

          if (match?.group(2)?.isNotEmpty == true) {
            list.add(UserTagElement('@${match!.group(2)!}'));
          }

          if (text.isNotEmpty) {
            list.addAll(parse([TextElement(text)], options));
          }
        }
      } else {
        list.add(element);
      }
    }

    return list;
  }
}

final _userTagRegex = RegExp(
  r'^(.*?)@([\w@]+(?:[.!][\w@]+)*)',
  caseSensitive: false,
  dotAll: true,
);

class UserTagElement extends LinkableElement {
  final String userTag;

  UserTagElement(this.userTag) : super(userTag, userTag);

  @override
  String toString() {
    return "UserTagElement: '$userTag' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  int get hashCode => Object.hash(text, originText, url, userTag);

  @override
  bool equals(other) =>
      other is UserTagElement &&
      super.equals(other) &&
      other.userTag == userTag;
}
