import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

import 'zego_sdk_manager.dart';

export 'zego_sdk_manager.dart';

class ZegoLiveAudioRoomManager {
  factory ZegoLiveAudioRoomManager() => instance;
  ZegoLiveAudioRoomManager._internal();
  static final ZegoLiveAudioRoomManager instance =
      ZegoLiveAudioRoomManager._internal();

  static const String roomKey = 'audioRoom';

  Map<String, dynamic> roomExtraInfoDict = {};
  List<StreamSubscription<dynamic>> subscriptions = [];

  ValueNotifier<bool> isLockSeat = ValueNotifier(false);
  ValueNotifier<ZegoSDKUser?> hostUserNotifier = ValueNotifier(null);
  ValueNotifier<ZegoLiveAudioRoomRole> roleNotifier =
      ValueNotifier(ZegoLiveAudioRoomRole.audience);

  RoomSeatService? roomSeatService;

  int get hostSeatIndex {
    return roomSeatService?.hostSeatIndex ?? 0;
  }

  List<ZegoLiveAudioRoomSeat> get seatList {
    return roomSeatService?.seatList ?? [];
  }

  set seatList(List<ZegoLiveAudioRoomSeat> value) =>
      roomSeatService?.seatList = value;

  Future<ZegoRoomLoginResult> loginRoom(
    String roomID,
    ZegoLiveAudioRoomRole role, {
    String? token,
  }) async {
    roomSeatService = RoomSeatService();
    roleNotifier.value = role;
    final expressService = ZEGOSDKManager().expressService;
    final zimService = ZEGOSDKManager().zimService;
    subscriptions.addAll([
      expressService.roomExtraInfoUpdateCtrl.stream
          .listen(onRoomExtraInfoUpdate),
      expressService.roomUserListUpdateStreamCtrl.stream
          .listen(onRoomUserListUpdate),
      zimService.onRoomCommandReceivedEventStreamCtrl.stream
          .listen(onRoomCommandReceived)
    ]);
    roomSeatService?.initWithConfig(role);
    return ZEGOSDKManager().loginRoom(
      roomID,
      ZegoScenario.HighQualityChatroom,
      token: token,
    );
  }

  void unInit() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
    subscriptions.clear();
    roomSeatService?.unInit();
  }

  bool isSeatLocked() {
    return isLockSeat.value;
  }

  Future<ZegoRoomSetRoomExtraInfoResult> lockSeat() async {
    roomExtraInfoDict['lockseat'] = !isLockSeat.value;
    final dataJson = jsonEncode(roomExtraInfoDict);

    final result = await ZEGOSDKManager()
        .expressService
        .setRoomExtraInfo(roomKey, dataJson);
    if (result.errorCode == 0) {
      isLockSeat.value = !isLockSeat.value;
    }
    return result;
  }

  Future<ZIMRoomAttributesOperatedCallResult?> takeSeat(
    int seatIndex, {
    bool? isForce,
  }) async {
    final result = await roomSeatService?.takeSeat(seatIndex, isForce: isForce);
    if (result != null) {
      if (!result.errorKeys.contains(seatIndex.toString())) {
        for (final element in seatList) {
          if (element.seatIndex == seatIndex) {
            if (roleNotifier.value != ZegoLiveAudioRoomRole.host) {
              roleNotifier.value = ZegoLiveAudioRoomRole.speaker;
            }
            break;
          }
        }
      }
    }
    if (result != null &&
        !result.errorKeys.contains(ZEGOSDKManager().currentUser!.userID)) {
      openMicAndStartPublishStream();
    }
    return result;
  }

  void openMicAndStartPublishStream() {
    ZEGOSDKManager().expressService.turnCameraOn(false);
    ZEGOSDKManager().expressService.turnMicrophoneOn(true);
    ZEGOSDKManager().expressService.startPublishingStream(generateStreamID());
  }

  String generateStreamID() {
    final userID = ZEGOSDKManager().currentUser!.userID;
    final roomID = ZEGOSDKManager().expressService.currentRoomID;
    final streamID =
        '${roomID}_${userID}_${ZegoLiveAudioRoomManager().roleNotifier.value == ZegoLiveAudioRoomRole.host ? 'host' : 'speaker'}';
    return streamID;
  }

  Future<ZIMRoomAttributesBatchOperatedResult?> switchSeat(
    int fromSeatIndex,
    int toSeatIndex,
  ) async {
    return roomSeatService?.switchSeat(fromSeatIndex, toSeatIndex);
  }

  Future<ZIMRoomAttributesOperatedCallResult?> leaveSeat(int seatIndex) async {
    return roomSeatService?.leaveSeat(seatIndex);
  }

  Future<ZIMRoomAttributesOperatedCallResult?> removeSpeakerFromSeat(
    String userID,
  ) async {
    return roomSeatService?.removeSpeakerFromSeat(userID);
  }

  Future<ZIMMessageSentResult> muteSpeaker(
    String userID,
    bool isMute,
  ) async {
    final messageType =
        isMute ? RoomCommandType.muteSpeaker : RoomCommandType.unMuteSpeaker;
    final commandMap = {
      'room_command_type': messageType,
      'receiver_id': userID
    };
    final result = await ZEGOSDKManager()
        .zimService
        .sendRoomCommand(jsonEncode(commandMap));
    return result;
  }

  Future<ZIMMessageSentResult> kickOutRoom(
    String userID,
  ) async {
    final commandMap = {
      'room_command_type': RoomCommandType.kickOutRoom,
      'receiver_id': userID
    };
    final result = await ZEGOSDKManager()
        .zimService
        .sendRoomCommand(jsonEncode(commandMap));
    return result;
  }

  void logoutRoom() {
    ZEGOSDKManager().logoutRoom();
    clear();
  }

  void clear() {
    roomSeatService?.clear();
    roomExtraInfoDict.clear();
    isLockSeat.value = false;
    hostUserNotifier.value = null;
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
    subscriptions.clear();
  }

  Future<ZegoRoomSetRoomExtraInfoResult?> setSelfHost() async {
    if (ZEGOSDKManager().currentUser == null) {
      return null;
    }
    roomExtraInfoDict['host'] = ZEGOSDKManager().currentUser!.userID;
    final dataJson = jsonEncode(roomExtraInfoDict);
    final result = await ZEGOSDKManager()
        .expressService
        .setRoomExtraInfo(roomKey, dataJson);
    if (result.errorCode == 0) {
      roleNotifier.value = ZegoLiveAudioRoomRole.host;
      hostUserNotifier.value = ZEGOSDKManager().currentUser;
    }
    return result;
  }

  String? getUserAvatar(String userID) {
    return ZEGOSDKManager().zimService.getUserAvatar(userID);
  }

  void onRoomExtraInfoUpdate(ZegoRoomExtraInfoEvent event) {
    for (final extraInfo in event.extraInfoList) {
      if (extraInfo.key == roomKey) {
        roomExtraInfoDict = jsonDecode(extraInfo.value);
        if (roomExtraInfoDict.containsKey('lockseat')) {
          final bool temp = roomExtraInfoDict['lockseat'];
          isLockSeat.value = temp;
        }
        if (roomExtraInfoDict.containsKey('host')) {
          final String tempUserID = roomExtraInfoDict['host'];
          hostUserNotifier.value = getHostUser(tempUserID);
        }
      }
    }
  }

  void onRoomUserListUpdate(ZegoRoomUserListUpdateEvent event) {
    if (event.updateType == ZegoUpdateType.Add) {
      final userIDList = <String>[];
      for (final element in event.userList) {
        userIDList.add(element.userID);
      }
      ZEGOSDKManager().zimService.queryUsersInfo(userIDList);
    } else {
      // empty seat
    }
  }

  void onRoomCommandReceived(OnRoomCommandReceivedEvent event) {
    final roomController = Get.find<RoomController>();
    final Map<String, dynamic> messageMap = jsonDecode(event.command);
    if (messageMap.keys.contains('room_command_type')) {
      final type = messageMap['room_command_type'];
      final receiverID = messageMap['receiver_id'];

      if (type == RoomCommandType.muteSpeaker) {
        roomController.mutedList.add(receiverID);
        if (receiverID == ZEGOSDKManager().currentUser!.userID) {
          showSnackBarWidget(message: AppStrings.youHaveBeenMutedByTheAdmin);
          ZEGOSDKManager().expressService.turnMicrophoneOn(false);
          roomController.micState = false;
        }
      } else if (type == RoomCommandType.unMuteSpeaker) {
        roomController.mutedList.remove(receiverID);
        if (receiverID == ZEGOSDKManager().currentUser!.userID) {
          showSnackBarWidget(
            message: AppStrings.youHaveBeenUnmutedByTheAdmin,
            color: ColorManager.green,
          );
          ZEGOSDKManager().expressService.turnMicrophoneOn(true);
          roomController.micState = true;
        }
      } else if (type == RoomCommandType.kickOutRoom) {
        if (receiverID == ZEGOSDKManager().currentUser!.userID) {
          roomController.backToMainRoute();
          showSnackBarWidget(message: AppStrings.youHaveBeenKickedOutOfTheRoom);
        }
      }
    }
  }

  ZegoSDKUser? getHostUser(String userID) {
    return ZEGOSDKManager().getUser(userID);
  }
}
