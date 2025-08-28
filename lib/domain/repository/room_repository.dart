import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
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
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/room_entity/gift_entity.dart';
import 'package:new_sai/domain/entity/room_entity/joined_room_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_banners_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_gift_users_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_message_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_pagination_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_settings_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_user_entity.dart';
import 'package:new_sai/domain/entity/room_entity/zego_token_entity.dart';

abstract class RoomRepository {
  Future<Either<Failure, RoomEntity>> getMyRoom();

  Future<Either<Failure, RoomPaginationEntity>> getPopularRooms(int params);

  Future<Either<Failure, RoomPaginationEntity>> getFamousRooms(int params);

  Future<Either<Failure, RoomPaginationEntity>> getMemperRooms(int params);

  Future<Either<Failure, RoomBannersEntity>> getRoomBanners();

  Future<Either<Failure, RoomEntity>> createRoom(CreateRoomParams params);

  Future<Either<Failure, JoinedRoomEntity>> joinRoom(String params);

  Future<Either<Failure, dynamic>> leaveRoom(String params);

  Future<Either<Failure, ZegoTokenEntity>> generateZegoToken(
      GenerateZegoTokenParams params);

  Future<Either<Failure, List<GiftEntity>>> getGiftList();

  Future<Either<Failure, RoomSettingsEntity>> getRoomSettings(String params);

  Future<Either<Failure, JoinedRoomEntity>> updateRoomSettings(
      UpdateRoomSettingsParams params);

  Future<Either<Failure, RoomMessageEntity>> sendRoomMessage(
      SendRoomMessageParams params);

  Future<Either<Failure, dynamic>> lockMic(LockUnlockMicParams params);

  Future<Either<Failure, dynamic>> unlockMic(LockUnlockMicParams params);

  Future<Either<Failure, dynamic>> lockRoom(LockRoomParams params);

  Future<Either<Failure, dynamic>> unlockRoom(String params);

  Future<Either<Failure, UserPaginationEntity>> getRoomMempers(dynamic params);

  Future<Either<Failure, dynamic>> fireUser(FireUserParams params);

  Future<Either<Failure, dynamic>> cancelFireUser(FireUserParams params);

  Future<Either<Failure, List<UserEntity>>> fireUserList(String params);

  Future<Either<Failure, RoomUserEntity>> getRoomUser(RoomUserParams params);

  Future<Either<Failure, dynamic>> updateUserRole(UpdateRoleParams params);

  Future<Either<Failure, dynamic>> joinAsMember(String params);

  Future<Either<Failure, dynamic>> cancelMembership(UpdateRoleParams params);

  Future<Either<Failure, dynamic>> sendRoomReport(RoomReportParams params);

  Future<Either<Failure, List<UserEntity>>> getUsersInRoom(List<String> params);

  Future<Either<Failure, dynamic>> sendRoomGift(SendGiftParams params);

  Future<Either<Failure, RoomPaginationEntity>> getRoomByCountryId(
      dynamic params);

  Future<Either<Failure, List<UserEntity>>> getGlobalStatistics(
      GlobalStatisticsParams params);

  Future<Either<Failure, RoomGiftUsersEntityPagination>> getRoomGiftUsers(
      Map<String, dynamic> params);
}
