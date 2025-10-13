// import 'package:animate_do/animate_do.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:get/get.dart';
// import 'package:new_sai/app/extensions.dart';
// import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
// import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
// import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/message_widget_model.dart';
// import 'package:new_sai/presentation/resources/color_manger.dart';
// import 'package:new_sai/presentation/resources/font_manger.dart';
// import 'package:new_sai/presentation/resources/language_manger.dart';
// import 'package:new_sai/presentation/widgets/app_image.dart';
// import 'package:new_sai/presentation/widgets/privilege_data_view.dart';
// import 'room_image_view.dart';
// import 'dart:ui' as ui;
//
// class MessageWidget extends GetView<RoomController> {
//   final MessageWidgetModel message;
//   final void Function() onConfirmDelete;
//
//   const MessageWidget({
//     super.key,
//     required this.message,
//     required this.onConfirmDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (context.locale == arabicLocale) {
//       return SlideInRight(
//           duration: const Duration(milliseconds: 450),
//           child: messageWidget(context));
//     }
//     return SlideInLeft(
//       duration: const Duration(milliseconds: 450),
//       child: messageWidget(context),
//     );
//   }
//
//   Widget messageWidget(BuildContext context) {
//     final userId = int.parse(message.user.userID);
//
//     return FutureBuilder<UserEntity>(
//       future: controller.getSenderProfile(userId),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         }
//
//         final sender = snapshot.data!;
//         final privileges = sender.privileges;
//         print('exclusiveChatBox');
//         print(sender.privileges.data.exclusiveChatBox.file);
//
//         return Obx(() {
//           return Dismissible(
//             key: ValueKey(message.user.userID),
//             background: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Row(
//                 children: [
//                   Icon(
//                     Icons.reply,
//                     color: ColorManager.white,
//                     size: 20,
//                   ),
//                 ],
//               ),
//             ),
//             direction: message.user.userID ==
//                     controller.appController.user.id.toString()
//                 ? DismissDirection.none
//                 : DismissDirection.startToEnd,
//             dismissThresholds: const {
//               DismissDirection.startToEnd: .2,
//             },
//             confirmDismiss: (direction) async {
//               onConfirmDelete();
//               return false;
//             },
//             child: Container(
//               padding: const EdgeInsets.all(10.0),
//               constraints: BoxConstraints(
//                 maxWidth: .75.w(context),
//               ),
//               margin: const EdgeInsets.only(bottom: 9),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       controller.openProfileBottomSheet(message.user.userID);
//                     },
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(40),
//                           child: Image.network(
//                             controller.getUserImage(message.user.userID),
//                             errorBuilder: (context, error, stackTrace) {
//                               return controller.userErrorImageWidget(
//                                 width: 30,
//                                 height: 30,
//                               );
//                             },
//                             width: 30,
//                             height: 30,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         if (sender.isVip == 1)
//                           PrivilegeDataView(
//                             url: privileges.data.profileFrame.file,
//                             width: 40,
//                             height: 40,
//                           )
//                       ],
//                     ),
//                   ),
//                   Flexible(
//                     fit: FlexFit.loose,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             controller
//                                 .openProfileBottomSheet(message.user.userID);
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Flexible(
//                                 child: Text(
//                                   message.user.userName,
//                                   style: Get.textTheme.bodySmall!.copyWith(
//                                     fontSize: AppSize.s17(context),
//                                     color: sender.isVip == 1
//                                         ? sender
//                                             .privileges.data.colorfulName.value
//                                             .toColor()
//                                         : null,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               5.horizontalSpace(),
//                               if (sender.badges.isNotEmpty) ...[
//                                 2.horizontalSpace(),
//                                 if (sender.isVip == 1)
//                                   PrivilegeDataView(
//                                     isBadges: true,
//                                     url: sender.badges.first,
//                                     width: 20,
//                                     height: 20,
//                                     fit: BoxFit.cover,
//                                   ),
//                               ],
//                               if (sender.isVip == 1)
//                                 AppImage(
//                                   image: privileges.categoryIcon,
//                                   height: 25,
//                                   width: 25,
//                                 )
//                             ],
//                           ),
//                         ),
//                         if (message.message != null &&
//                             message.message!.isNotEmpty)
//                           Stack(
//                             alignment: AlignmentDirectional.center,
//                             children: [
//                               if (sender.isVip == 1)
//                                 Positioned.fill(
//                                   child: PrivilegeDataView(
//                                     url: privileges.data.exclusiveChatBox.file,
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               Directionality(
//                                 textDirection:
//                                 controller.isArabic(message.message!)
//                                     ? ui.TextDirection.rtl
//                                     : ui.TextDirection.ltr,
//                                 child: Container(
//                                   padding: sender.isVip == 1
//                                       ? const EdgeInsetsDirectional.only(
//                                           top: 30, end: 25, start: 30, bottom: 25)
//                                       : const EdgeInsets.all(5.0),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: sender.isVip == 1
//                                         ? null
//                                         : ColorManager.black.withOpacity(0.5),
//                                   ),
//                                   child: Linkify(
//                                     text: message.message!,
//                                     maxLines: 4,
//                                     textAlign:
//                                         controller.isArabic(message.message!)
//                                             ? TextAlign.right
//                                             : TextAlign.left,
//                                     softWrap: true,
//                                     style: Get.textTheme.bodySmall!.copyWith(
//                                       fontSize: AppSize.s14(context),
//                                     ),
//                                     linkStyle:
//                                         Get.textTheme.bodyLarge!.copyWith(
//                                       fontSize: AppSize.s14(context),
//                                     ),
//                                     linkifiers: const [
//                                       UserTagLinkifier(),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         if (message.image != null) ...[
//                           5.verticalSpace(),
//                           InkWell(
//                             onTap: () {
//                               Get.dialog(RoomImageView(image: message.image!));
//                             },
//                             child: AppImage(
//                               image: message.image!,
//                               width: 180,
//                               height: 180,
//                               radius: 8,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }
// }
//
// class UserTagLinkifier extends Linkifier {
//   const UserTagLinkifier();
//
//   @override
//   List<LinkifyElement> parse(elements, options) {
//     final list = <LinkifyElement>[];
//
//     for (var element in elements) {
//       if (element is TextElement) {
//         var match = _userTagRegex.firstMatch(element.text);
//
//         if (match == null) {
//           list.add(element);
//         } else {
//           var textElement = '';
//           var text = element.text.replaceFirst(match.group(0)!, '');
//           while (match?.group(1)?.contains(RegExp(r'[\w@]$')) == true) {
//             textElement += match!.group(0)!;
//             match = _userTagRegex.firstMatch(text);
//             if (match == null) {
//               textElement += text;
//               text = '';
//             } else {
//               text = text.replaceFirst(match.group(0)!, '');
//             }
//           }
//
//           if (textElement.isNotEmpty || match?.group(1)?.isNotEmpty == true) {
//             list.add(TextElement(textElement + (match?.group(1) ?? '')));
//           }
//
//           if (match?.group(2)?.isNotEmpty == true) {
//             list.add(UserTagElement('@${match!.group(2)!}'));
//           }
//
//           if (text.isNotEmpty) {
//             list.addAll(parse([TextElement(text)], options));
//           }
//         }
//       } else {
//         list.add(element);
//       }
//     }
//
//     return list;
//   }
// }
//
// final _userTagRegex = RegExp(
//   r'^(.*?)@([\w@]+(?:[.!][\w@]+)*)',
//   caseSensitive: false,
//   dotAll: true,
// );
//
// class UserTagElement extends LinkableElement {
//   final String userTag;
//
//   UserTagElement(this.userTag) : super(userTag, userTag);
//
//   @override
//   String toString() {
//     return "UserTagElement: '$userTag' ($text)";
//   }
//
//   @override
//   bool operator ==(other) => equals(other);
//
//   @override
//   int get hashCode => Object.hash(text, originText, url, userTag);
//
//   @override
//   bool equals(other) =>
//       other is UserTagElement &&
//       super.equals(other) &&
//       other.userTag == userTag;
// }
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/room_entity/room_user_entity.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/message_widget_model.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';
import 'room_image_view.dart';
import 'dart:ui' as ui;

class MessageWidget extends GetView<RoomController> {
  final MessageWidgetModel message;
  final void Function() onConfirmDelete;

  const MessageWidget({
    super.key,
    required this.message,
    required this.onConfirmDelete,
  });

  @override
  Widget build(BuildContext context) {
    return messageWidget(context);
  }

  Widget messageWidget(BuildContext context) {
    final userId = int.parse(message.user.userID);

    return Obx((){
      controller.refreshMessagesTrigger.value;
      return FutureBuilder<RoomUserEntity>(
        future: controller.getSenderProfile(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }

          final sender = snapshot.data!;
          final privileges = sender.privileges;


          return Obx(() {
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
                  controller.appController.user.id.toString()
                  ? DismissDirection.none
                  : DismissDirection.startToEnd,
              dismissThresholds: const {
                DismissDirection.startToEnd: .2,
              },
              confirmDismiss: (direction) async {
                onConfirmDelete();
                return false;
              },
              child: Padding(
                padding: sender.isVip == 1 ? EdgeInsets.zero :  const EdgeInsetsDirectional.only(start: 10),
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  constraints: BoxConstraints(
                    maxWidth: .80.w(context),
                  ),
                  margin: sender.isVip == 1 ? null : const EdgeInsets.only(bottom: 9),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.openProfileBottomSheet(message.user.userID);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                controller.getUserImage(message.user.userID),
                                errorBuilder: (context, error, stackTrace) {
                                  return controller.userErrorImageWidget(
                                    width: 30,
                                    height: 30,
                                  );
                                },
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (sender.isVip == 1)
                              PrivilegeDataView(
                                url: privileges.data.profileFrame.file,
                                width: 50,
                                height: 50,
                              )
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                controller
                                    .openProfileBottomSheet(message.user.userID);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: sender.role == "owner"
                                        ? ColorManager.red
                                        : sender.role == "admin"
                                        ? Colors.yellow
                                        : Colors.grey,
                                    size: 20.0,
                                  ),
                                  2.horizontalSpace(),
                                  Flexible(
                                    child: Text(
                                      message.user.userName,
                                      style: Get.textTheme.bodySmall!.copyWith(
                                        fontSize: AppSize.s17(context),
                                        color: sender.isVip == 1
                                            ? sender
                                            .privileges.data.colorfulName.value
                                            .toColor()
                                            : null,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  5.horizontalSpace(),
                                  if (sender.isVip == 1)
                                    AppImage(
                                      image: privileges.categoryIcon,
                                      height: 25,
                                      width: 25,
                                    )
                                ],
                              ),
                            ),
                            if (message.message != null &&
                                message.message!.isNotEmpty)
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  if (sender.isVip == 1)
                                    Positioned.fill(
                                      child: PrivilegeDataView(
                                        url: privileges.data.exclusiveChatBox.file,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  Directionality(
                                    textDirection:
                                    controller.isArabic(message.message!)
                                        ? ui.TextDirection.rtl
                                        : ui.TextDirection.ltr,
                                    child: Container(
                                      padding: sender.isVip == 1
                                          ? const EdgeInsetsDirectional.only(
                                          end: 30,
                                          start: 35, top: 28   , bottom: 25)
                                          : const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: sender.isVip == 1
                                            ? null
                                            : ColorManager.black.withOpacity(0.60),
                                      ),
                                      child: Linkify(
                                        text: message.message!,
                                        maxLines: 4,
                                        textAlign:
                                        controller.isArabic(message.message!)
                                            ? TextAlign.right
                                            : TextAlign.left,
                                        softWrap: true,
                                        style: Get.textTheme.bodySmall!.copyWith(
                                            fontSize: AppSize.s14(context),
                                            fontWeight: FontWeightManger.medium
                                        ),
                                        linkStyle:
                                        Get.textTheme.bodyLarge!.copyWith(
                                          fontSize: AppSize.s14(context),
                                        ),
                                        linkifiers: const [
                                          UserTagLinkifier(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
              ),
            );
          });
        },
      );
    });
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