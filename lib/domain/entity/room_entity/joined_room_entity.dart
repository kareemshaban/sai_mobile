import 'package:new_sai/domain/entity/auth_entity/privileges_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_settings_entity.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_update_settings_model.dart';

class JoinedRoomEntity {
  num id;
  num maxuser;
  num referenceId;
  num ownerId;
  String totalGold;
  String roomImage;
  String roomName;
  String generalNotificationContent;
  String helloMesaage;
  String userMessage;
  num microphonesCount;
  bool isBlocked;
  bool isFierd;
  RoomSettingsEntity settings;
  num membershipFee;
  String role;
  num goldValue;
  String backgroundTheme;
  PrivilegesEntity privileges;
  List<String> badges;
  List<int> micStatues;
  String lockCode;
  String zegoToken;

  JoinedRoomEntity({
    required this.generalNotificationContent,
    required this.roomImage,
    required this.roomName,
    required this.privileges,
    required this.referenceId,
    required this.id,
    required this.badges,
    required this.isBlocked,
    required this.settings,
    required this.goldValue,
    required this.helloMesaage,
    required this.isFierd,
    required this.maxuser,
    required this.membershipFee,
    required this.microphonesCount,
    required this.ownerId,
    required this.role,
    required this.totalGold,
    required this.userMessage,
    required this.backgroundTheme,
    required this.micStatues,
    required this.lockCode,
    required this.zegoToken,
  });

  JoinedRoomEntity copyFromSettings(RoomUpdateSettingsModel model) {
    return JoinedRoomEntity(
      generalNotificationContent: model.roomNotification,
      roomImage: model.roomImage,
      roomName: model.roomName,
      privileges: privileges,
      referenceId: referenceId,
      id: id,
      badges: badges,
      isBlocked: isBlocked,
      settings: settings,
      goldValue: goldValue,
      helloMesaage: helloMesaage,
      isFierd: isFierd,
      maxuser: maxuser,
      membershipFee: model.roomMemperFee,
      microphonesCount: model.roomMicsCount,
      ownerId: ownerId,
      role: role,
      totalGold: totalGold,
      userMessage: userMessage,
      backgroundTheme: backgroundTheme,
      micStatues: micStatues,
      lockCode: lockCode,
      zegoToken: zegoToken,
    );
  }

  JoinedRoomEntity updateRole(String? role) {
    return JoinedRoomEntity(
      generalNotificationContent: generalNotificationContent,
      roomImage: roomImage,
      roomName: roomName,
      privileges: privileges,
      referenceId: referenceId,
      id: id,
      badges: badges,
      isBlocked: isBlocked,
      settings: settings,
      goldValue: goldValue,
      helloMesaage: helloMesaage,
      isFierd: isFierd,
      maxuser: maxuser,
      membershipFee: membershipFee,
      microphonesCount: microphonesCount,
      ownerId: ownerId,
      role: role ?? this.role,
      totalGold: totalGold,
      userMessage: userMessage,
      backgroundTheme: backgroundTheme,
      micStatues: micStatues,
      lockCode: lockCode,
      zegoToken: zegoToken,
    );
  }
}
