import 'package:new_sai/app/constants.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/mapper/auth_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/auth_model/privileges_model.dart';
import 'package:new_sai/data/model/room_model/gift_model.dart';
import 'package:new_sai/data/model/room_model/joined_room_model.dart';
import 'package:new_sai/data/model/room_model/room_banners_model.dart';
import 'package:new_sai/data/model/room_model/room_gift_users_model.dart';
import 'package:new_sai/data/model/room_model/room_message_model.dart';
import 'package:new_sai/data/model/room_model/room_model.dart';
import 'package:new_sai/data/model/room_model/room_pagination_model.dart';
import 'package:new_sai/data/model/room_model/room_settings_model.dart';
import 'package:new_sai/data/model/room_model/room_user_model.dart';
import 'package:new_sai/data/model/room_model/tag_model.dart';
import 'package:new_sai/data/model/room_model/zego_token_model.dart';
import 'package:new_sai/domain/entity/room_entity/gift_entity.dart';
import 'package:new_sai/domain/entity/room_entity/joined_room_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_banners_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_gift_users_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_message_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_pagination_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_settings_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_user_entity.dart';
import 'package:new_sai/domain/entity/room_entity/tag_entity.dart';
import 'package:new_sai/domain/entity/room_entity/zego_token_entity.dart';

extension RoomPaginationMapper on RoomPaginationModel? {
  RoomPaginationEntity toDomain() {
    return RoomPaginationEntity(
      data: this?.data != null
          ? this!.data!.map((e) => e.toDomain()).toList()
          : [],
      pagination: this?.pagination != null
          ? this!.pagination.toDomain()
          : PaginationModel().toDomain(),
    );
  }
}

extension RoomMapper on RoomModel? {
  RoomEntity toDomain() {
    return RoomEntity(
      id: this?.id ?? Constants.zero,
      roomReferenceId: this?.roomReferenceId ?? Constants.zero,
      roomImage: this?.roomImage ?? Constants.empty,
      roomName: this?.roomName ?? Constants.empty,
      generalNotificationContent:
          this?.generalNotificationContent ?? Constants.empty,
      tag: this?.tag != null ? this!.tag.toDomain() : TagModel().toDomain(),
      membersCount: this?.membersCount ?? Constants.zero,
      profileLevel: this?.profileLevel ?? Constants.zero,
      falg: this?.falg ?? Constants.empty,
      lockCode: this?.lockCode ?? Constants.empty,
      backgroundTheme: this?.backgroundTheme ?? Constants.empty,
    );
  }
}

extension TagMapper on TagModel? {
  TagEntity toDomain() {
    return TagEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
    );
  }
}

extension RoomBannersMapper on RoomBannersModel? {
  RoomBannersEntity toDomain() {
    return RoomBannersEntity(
      topBillionares:
          this?.topBillionares?.map((e) => e.toDomain()).toList() ?? [],
      topRooms: this?.topRooms?.map((e) => e.toDomain()).toList() ?? [],
      topSenders: this?.topSenders?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension RoomBannerItemMapper on RoomBannerItemModel? {
  RoomBannerItemEntity toDomain() {
    return RoomBannerItemEntity(
      age: this?.age ?? Constants.zero,
      referenceId: this?.referenceId ?? Constants.zero,
      profileImg: this?.profileImg ?? Constants.empty,
      gender: this?.gender ?? Constants.empty,
      profileLevel: this?.profileLevel ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      privileges: this?.privileges?.toDomain() ?? PrivilegesModel().toDomain(),
      totla: this?.totla ?? Constants.empty,
      userId: this?.userId ?? Constants.zero,
      onlineUsersCount: this?.onlineUsersCount ?? Constants.zero,
      chatRoomId: this?.chatRoomId ?? Constants.zero,
      lockCode: this?.lockCode ?? Constants.empty,
    );
  }
}

extension JoinedRoomMapper on JoinedRoomModel? {
  JoinedRoomEntity toDomain() {
    return JoinedRoomEntity(
      generalNotificationContent:
          this?.generalNotificationContent ?? Constants.empty,
      roomImage: this?.roomImage ?? Constants.empty,
      roomName: this?.roomName ?? Constants.empty,
      privileges: this?.privileges?.toDomain() ?? PrivilegesModel().toDomain(),
      referenceId: this?.referenceId ?? Constants.zero,
      id: this?.id ?? Constants.zero,
      badges: this?.badges ?? [],
      isBlocked: this?.isBlocked == 1,
      settings: this?.settings?.toDomain() ?? RoomSettingsModel().toDomain(),
      goldValue: this?.goldValue ?? Constants.zero,
      helloMesaage: this?.helloMesaage ?? Constants.empty,
      isFierd: this?.isFierd ?? false,
      maxuser: this?.maxuser ?? Constants.zero,
      membershipFee: this?.membershipFee ?? Constants.zero,
      microphonesCount: this?.microphonesCount ?? Constants.zero,
      ownerId: this?.ownerId ?? Constants.zero,
      role: this?.role ?? Constants.empty,
      totalGold: this?.totalGold ?? Constants.empty,
      userMessage: this?.userMessage ?? Constants.empty,
      backgroundTheme: this?.backgroundTheme ?? Constants.empty,
      micStatues: this?.micStatues ?? [],
      lockCode: this?.lockCode ?? Constants.empty,
      zegoToken: this?.zegoToken ?? Constants.empty,
    );
  }
}

extension RoomSettingsMapper on RoomSettingsModel? {
  RoomSettingsEntity toDomain() {
    return RoomSettingsEntity(
      profileImage: this?.profileImage ?? Constants.empty,
      roomName: this?.roomName ?? Constants.empty,
      notificationContent: this?.notificationContent ?? Constants.empty,
      tagId: this?.tagId ?? Constants.zero,
      tags: this?.tags?.map((e) => e.toDomain()).toList() ?? [],
      membershipFee: this?.membershipFee ?? Constants.zero,
      microphonesCount: this?.microphonesCount ?? Constants.zero,
      adminLockMic: this?.adminLockMic ?? Constants.zero,
      adminRequestMic: this?.adminRequestMic ?? Constants.zero,
      guestJoinRoom: this?.guestJoinRoom ?? Constants.zero,
      requestMic: this?.requestMic ?? Constants.empty,
    );
  }
}

extension ZegoTokenMapper on ZegoTokenModel? {
  ZegoTokenEntity toDomain() {
    return ZegoTokenEntity(
      zegoToken: this?.zegoToken ?? Constants.empty,
    );
  }
}

extension GiftMapper on GiftModel? {
  GiftEntity toDomain() {
    return GiftEntity(
      id: this?.id ?? Constants.zero,
      category: this?.category?.toDomain() ?? GiftCategoryModel().toDomain(),
      giftImg: this?.giftImg ?? Constants.empty,
      giftFile: this?.giftFile ?? Constants.empty,
      goldValue: this?.goldValue ?? Constants.zero,
    );
  }
}

extension GiftCategoryMapper on GiftCategoryModel? {
  GiftCategoryEntity toDomain() {
    return GiftCategoryEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
    );
  }
}

extension RoomMessageMapper on RoomMessageModel? {
  RoomMessageEntity toDomain() {
    return RoomMessageEntity(
      message: this?.message ?? Constants.empty,
      userName: this?.userName ?? Constants.empty,
      role: this?.role ?? Constants.empty,
      profileImg: this?.profileImg ?? Constants.empty,
      image: this?.image ?? Constants.empty,
      badges: this?.badges ?? [],
      privileges: this?.privileges?.toDomain() ?? PrivilegesModel().toDomain(),
      chatRoomId: this?.chatRoomId ?? Constants.empty,
      refrenceId: this?.refrenceId ?? Constants.zero,
      userId: this?.userId ?? Constants.zero,
    );
  }
}

extension RoomUserMapper on RoomUserModel? {
  RoomUserEntity toDomain() {
    return RoomUserEntity(
      referenceId: this?.referenceId ?? Constants.zero,
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      profileImg: this?.profileImg ?? Constants.empty,
      privileges: this?.privileges?.toDomain() ?? PrivilegesModel().toDomain(),
      badges: this?.badges ?? [],
      role: this?.role ?? Constants.empty,
      isFriend: this?.isFriend ?? false,
      isFollow: this?.isFollow ?? false,
      hasFriendRequest: this?.hasFriendRequest ?? false,
      conversationId: this?.conversationId ?? Constants.zero,
      friendRequestId: this?.friendRequestId ?? Constants.zero,
      level: this?.level ?? Constants.zero,
      sendFriendRequest: this?.sendFriendRequest ?? false,
      supportReceivedVal: this?.supportReceivedVal ?? Constants.empty,
      supportSentVal: this?.supportSentVal ?? Constants.empty,
      isFollowing: this?.isFollowing ?? false,
    );
  }
}

extension RoomGiftUsersPaginationMapper on RoomGiftUsersModelPagination? {
  RoomGiftUsersEntityPagination toDomain() {
    return RoomGiftUsersEntityPagination(
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
    );
  }
}

extension RoomGiftUsersMapper on RoomGiftUsersModel? {
  RoomGiftUsersEntity toDomain() {
    return RoomGiftUsersEntity(
      userName: this?.userName ?? Constants.empty,
      fromId: this?.fromId ?? Constants.zero,
      giftsCount: this?.giftsCount ?? Constants.zero,
      totalPrice: this?.totalPrice ?? Constants.empty,
      userImage: this?.userImage ?? Constants.empty,
      referenceId: this?.referenceId ?? Constants.zero,
      badges: this?.badges ?? [],
    );
  }
}
