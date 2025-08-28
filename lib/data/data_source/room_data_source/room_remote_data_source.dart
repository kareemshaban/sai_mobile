import 'package:dio/dio.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/model/auth_model/user_model.dart';
import 'package:new_sai/data/model/room_model/gift_model.dart';
import 'package:new_sai/data/model/room_model/joined_room_model.dart';
import 'package:new_sai/data/model/room_model/room_banners_model.dart';
import 'package:new_sai/data/model/room_model/room_gift_users_model.dart';
import 'package:new_sai/data/model/room_model/room_message_model.dart';
import 'package:new_sai/data/model/room_model/room_model.dart';
import 'package:new_sai/data/model/room_model/room_pagination_model.dart';
import 'package:new_sai/data/model/room_model/room_settings_model.dart';
import 'package:new_sai/data/model/room_model/room_user_model.dart';
import 'package:new_sai/data/model/room_model/zego_token_model.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/end_point.dart';
import 'package:new_sai/data/params/room_params/create_room_params.dart';
import 'package:new_sai/data/params/room_params/fire_user_params.dart';
import 'package:new_sai/data/params/room_params/generate_zego_token_params.dart';
import 'package:new_sai/data/params/room_params/global_statistics_params.dart';
import 'package:new_sai/data/params/room_params/lock_room_params.dart';
import 'package:new_sai/data/params/room_params/lock_unlock_mic_params.dart';
import 'package:new_sai/data/params/room_params/room_report_params.dart';
import 'package:new_sai/data/params/room_params/room_user_params.dart';
import 'package:new_sai/data/params/room_params/send_gift_params.dart';
import 'package:new_sai/data/params/room_params/send_message_params.dart';
import 'package:new_sai/data/params/room_params/update_role_params.dart';
import 'package:new_sai/data/params/room_params/update_room_settings_params.dart';

abstract class RoomRemoteDataSource {
  Future<BaseMapModel<RoomModel>> getMyRoom();

  Future<BaseMapModel<RoomPaginationModel>> getPopularRooms(int params);

  Future<BaseMapModel<RoomPaginationModel>> getFamousRooms(int params);

  Future<BaseMapModel<RoomPaginationModel>> getMemperRooms(int params);

  Future<BaseMapModel<RoomBannersModel>> getRoomBanners();

  Future<BaseMapModel<RoomModel>> createRoom(CreateRoomParams params);

  Future<BaseMapModel<JoinedRoomModel>> joinRoom(String params);

  Future<BaseMapModel> leaveRoom(String params);

  Future<BaseMapModel<ZegoTokenModel>> generateZegoToken(
      GenerateZegoTokenParams params);

  Future<BaseListModel<GiftModel>> getGiftList();

  Future<BaseMapModel<RoomSettingsModel>> getRoomSettings(String params);

  Future<BaseMapModel<JoinedRoomModel>> updateRoomSettings(
      UpdateRoomSettingsParams params);

  Future<BaseMapModel<RoomMessageModel>> sendRoomMessage(
      SendRoomMessageParams params);

  Future<BaseMapModel> lockMic(LockUnlockMicParams params);

  Future<BaseMapModel> unlockMic(LockUnlockMicParams params);

  Future<BaseMapModel> lockRoom(LockRoomParams params);

  Future<BaseMapModel> unlockRoom(String params);

  Future<BaseMapModel<UserPaginationModel>> getRoomMempers(dynamic params);

  Future<BaseMapModel> fireUser(FireUserParams params);

  Future<BaseMapModel> cancelFireUser(FireUserParams params);

  Future<BaseListModel<UserModel>> fireUserList(String params);

  Future<BaseMapModel<RoomUserModel>> getRoomUser(RoomUserParams params);

  Future<BaseMapModel> updateUserRole(UpdateRoleParams params);

  Future<BaseMapModel> joinAsMember(String params);

  Future<BaseMapModel> cancelMembership(UpdateRoleParams params);

  Future<BaseMapModel> sendRoomReport(RoomReportParams params);

  Future<BaseListModel<UserModel>> getUsersInRoom(List<String> params);

  Future<BaseMapModel> sendRoomGift(SendGiftParams params);

  Future<BaseMapModel<RoomPaginationModel>> getRoomByCountryId(dynamic params);

  Future<BaseListModel<UserModel>> getGlobalStatistics(
      GlobalStatisticsParams params);

  Future<BaseMapModel<RoomGiftUsersModelPagination>> getRoomGiftUsers(
      Map<String, dynamic> params);
}

class RoomRemoteDataSourceImpl extends RoomRemoteDataSource {
  final AppServiceClient _appServiceClient;
  RoomRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseMapModel<RoomModel>> getMyRoom() async {
    return await _appServiceClient.performGetRequest(
      EndPoint.myRoom,
      RoomModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<RoomPaginationModel>> getPopularRooms(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.popularRooms,
      RoomPaginationModel.fromJson,
      params: {
        'page': params,
      },
    );
  }

  @override
  Future<BaseMapModel<RoomPaginationModel>> getFamousRooms(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.famousRooms,
      RoomPaginationModel.fromJson,
      params: {
        'page': params,
      },
    );
  }

  @override
  Future<BaseMapModel<RoomPaginationModel>> getMemperRooms(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.memperRooms,
      RoomPaginationModel.fromJson,
      params: {
        'page': params,
      },
    );
  }

  @override
  Future<BaseMapModel<RoomBannersModel>> getRoomBanners() async {
    return await _appServiceClient.performGetRequest(
      EndPoint.roomBanners,
      RoomBannersModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<RoomModel>> createRoom(CreateRoomParams params) async {
    final data = FormData.fromMap(
      {
        if (params.roomName != null) 'room_name': params.roomName,
        if (params.roomImage != null)
          'room_image': await MultipartFile.fromFile(params.roomImage!),
        if (params.generalNotificationContent != null)
          'general_notification_content': params.generalNotificationContent,
      },
    );
    return await _appServiceClient.performPostRequest(
      EndPoint.createRoom,
      data,
      RoomModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<JoinedRoomModel>> joinRoom(String params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.joinRoom(params),
      JoinedRoomModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> leaveRoom(String params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.leaveRoom(params),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<ZegoTokenModel>> generateZegoToken(
      GenerateZegoTokenParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.generateZegoToken,
      params.toJson(),
      ZegoTokenModel.fromJson,
    );
  }

  @override
  Future<BaseListModel<GiftModel>> getGiftList() async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.giftList,
      GiftModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<RoomSettingsModel>> getRoomSettings(String params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.roomSettings(params),
      RoomSettingsModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<JoinedRoomModel>> updateRoomSettings(
      UpdateRoomSettingsParams params) async {
    final data = FormData.fromMap(
      {
        if (params.profileImage != null)
          'profile_img': await MultipartFile.fromFile(params.profileImage!),
        if (params.roomName != null) 'room_name': params.roomName,
        if (params.notificationContent != null)
          'general_notification': params.notificationContent,
        if (params.membershipFee != null)
          'membership_fee': params.membershipFee,
        if (params.microphonesCount != null)
          'miccount': params.microphonesCount,
      },
    );
    return await _appServiceClient.performPostRequest(
      EndPoint.updateRoomSettings(params.roomID!),
      data,
      JoinedRoomModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<RoomMessageModel>> sendRoomMessage(
      SendRoomMessageParams params) async {
    final data = FormData.fromMap(
      {
        if (params.message != null) 'message': params.message,
        if (params.image != null)
          'image': await MultipartFile.fromFile(params.image!),
      },
    );
    return await _appServiceClient.performPostRequest(
      EndPoint.sendRoomMessage(params.roomID!),
      data,
      RoomMessageModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> lockMic(LockUnlockMicParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.lockMic(params.roomID!),
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> unlockMic(LockUnlockMicParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.unlockMic(params.roomID!),
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> lockRoom(LockRoomParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.lockRoom(params.roomID!),
      {
        'lock_number': params.code,
      },
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> unlockRoom(String params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.unlockRoom(params),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<UserPaginationModel>> getRoomMempers(
      dynamic params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.getRoomMempers(params['id']),
      UserPaginationModel.fromJson,
      params: {
        "page": params['page'],
      },
    );
  }

  @override
  Future<BaseMapModel> fireUser(FireUserParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.fireUser(params.roomID!),
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> cancelFireUser(FireUserParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.cancelFireUser(params.roomID!),
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseListModel<UserModel>> fireUserList(String params) async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.getFireUserList(params),
      UserModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<RoomUserModel>> getRoomUser(RoomUserParams params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.getRoomUser(params),
      RoomUserModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> updateUserRole(UpdateRoleParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.updateUserRole,
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> joinAsMember(String params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.joinAsMember(params),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> cancelMembership(UpdateRoleParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.cancelMembership,
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> sendRoomReport(RoomReportParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.roomReport,
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseListModel<UserModel>> getUsersInRoom(List<String> params) async {
    return await _appServiceClient.performPostRequestList(
      EndPoint.usersList,
      {
        'ids': params,
      },
      UserModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> sendRoomGift(SendGiftParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.sendRoomGift(params.roomID!),
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<RoomPaginationModel>> getRoomByCountryId(
      dynamic params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.roomByCountry,
      RoomPaginationModel.fromJson,
      params: {
        "country_id": params['id'],
        "page": params['page'],
      },
    );
  }

  @override
  Future<BaseListModel<UserModel>> getGlobalStatistics(
      GlobalStatisticsParams params) async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.globalStatistics,
      UserModel.fromJson,
      params: params.toJson(),
    );
  }

  @override
  Future<BaseMapModel<RoomGiftUsersModelPagination>> getRoomGiftUsers(
      Map<String, dynamic> params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.roomGiftUsers(params['id']),
      RoomGiftUsersModelPagination.fromJson,
      params: {
        'page': params['page'],
      },
    );
  }
}
