import 'package:new_sai/app/constants.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/country_model.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/auth_model/privileges_model.dart';
import 'package:new_sai/data/model/auth_model/register_model.dart';
import 'package:new_sai/data/model/auth_model/user_model.dart';
import 'package:new_sai/domain/entity/auth_entity/privileges_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/register_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';

extension UserPaginationMapper on UserPaginationModel? {
  UserPaginationEntity toDomain() {
    return UserPaginationEntity(
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
    );
  }
}

extension UserMapper on UserModel? {
  UserEntity toDomain() {
    return UserEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      profileImg: this?.profileImg ?? Constants.empty,
      token: this?.token ?? Constants.empty,
      type: this?.type ?? Constants.empty,
      gender: this?.gender ?? Constants.empty,
      country: this?.country != null
          ? this!.country.toDomain()
          : CountryModel().toDomain(),
      followers: this?.followers ?? Constants.zero,
      age: this?.age ?? Constants.zero,
      appLang: this?.appLang ?? Constants.empty,
      chatroomCount: this?.chatroomCount ?? Constants.zero,
      followings: this?.followings ?? Constants.zero,
      friendsCount: this?.friendsCount ?? Constants.zero,
      hasFriendRequest: this?.hasFriendRequest ?? false,
      isBlocked: this?.isBlocked ?? false,
      isFollow: this?.isFollow ?? false,
      isFriend: this?.isFriend ?? false,
      isFollowing: this?.isFollowing ?? false,
      joinedDays: this?.joinedDays ?? Constants.zero,
      profileCover: this?.profileCover ?? Constants.empty,
      profileDescription: this?.profileDescription ?? Constants.empty,
      profileLevel: this?.profileLevel ?? Constants.zero,
      referenceId: this?.referenceId ?? Constants.zero,
      visitorsCount: this?.visitorsCount ?? Constants.empty,
      badges: this?.badges != null ? this!.badges!.map((e) => e).toList() : [],
      privileges: this?.privileges != null
          ? this!.privileges.toDomain()
          : PrivilegesModel().toDomain(),
      birthDate: this?.birthDate ?? Constants.empty,
      postsCount: this?.postsCount ?? Constants.zero,
      goldValue: this?.goldValue ?? Constants.zero,
      onlineUsersCount: this?.onlineUsersCount ?? Constants.zero,
      chatRoomId: this?.chatRoomId ?? Constants.zero,
      lockCode: this?.lockCode ?? Constants.empty,
      total: this?.total ?? Constants.empty,
      userID: this?.userID ?? Constants.zero,
      chatId: this?.chatId ?? Constants.zero,
      phone: this?.phone ?? Constants.empty,
      email: this?.email ?? Constants.empty,
      comment: this?.comment ?? Constants.empty,
      profile: this?.profile ?? Constants.empty,
      story: this?.story ?? Constants.empty,
      track: this?.track ?? Constants.empty,
      friendId: this?.friendId ?? Constants.zero,
      backgroundTheme: this?.backgroundTheme ?? Constants.empty,
    );
  }
}

extension RegisterMapper on RegisterModel? {
  RegisterEntity toDomain() {
    return RegisterEntity(
      type: this?.type ?? Constants.empty,
      phone: this?.phone ?? Constants.empty,
    );
  }
}

extension PrivilegesMapper on PrivilegesModel? {
  PrivilegesEntity toDomain() {
    return PrivilegesEntity(
      categoryId: this?.categoryId ?? Constants.zero,
      categoryName: this?.categoryName ?? Constants.empty,
      categoryIcon: this?.categoryIcon ?? Constants.empty,
      data: this?.data != null
          ? this!.data.toDomain()
          : PrivilegesDataModel().toDomain(),
    );
  }
}

extension PrivilegesDataMapper on PrivilegesDataModel? {
  PrivilegesDataEntity toDomain() {
    return PrivilegesDataEntity(
      profileCover: this?.profileCover != null
          ? this!.profileCover.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      friendsCount: this?.friendsCount != null
          ? this!.friendsCount.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      badgePremium: this?.badgePremium != null
          ? this!.badgePremium.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      chatroomLock: this?.chatroomLock != null
          ? this!.chatroomLock.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      colorfulName: this?.colorfulName != null
          ? this!.colorfulName.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      disableMuteAndFiering: this?.disableMuteAndFiering != null
          ? this!.disableMuteAndFiering.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      entryWithInfluences: this?.entryWithInfluences != null
          ? this!.entryWithInfluences.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      exclusiveChatBox: this?.exclusiveChatBox != null
          ? this!.exclusiveChatBox.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      exclusiveGifts: this?.exclusiveGifts != null
          ? this!.exclusiveGifts.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      exclusiveNameCard: this?.exclusiveNameCard != null
          ? this!.exclusiveNameCard.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      luxuryVehicles: this?.luxuryVehicles != null
          ? this!.luxuryVehicles.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      profileBorder: this?.profileBorder != null
          ? this!.profileBorder.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      profileCard: this?.profileCard != null
          ? this!.profileCard.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      profileFrame: this?.profileFrame != null
          ? this!.profileFrame.toDomain()
          : PrivilegesDataItemModel().toDomain(),
      roomBackcground: this?.roomBackcground != null
          ? this!.roomBackcground.toDomain()
          : PrivilegesDataItemModel().toDomain(),
    );
  }
}

extension PrivilegesDataItemMapper on PrivilegesDataItemModel? {
  PrivilegesDataItemEntity toDomain() {
    return PrivilegesDataItemEntity(
      name: this?.name ?? Constants.empty,
      value: this?.value ?? Constants.empty,
      id: this?.id ?? Constants.zero,
      file: this?.file ?? Constants.empty,
    );
  }
}

extension UserFriendMapper on UserFriendModel? {
  UserFriendEntity toDomain() {
    return UserFriendEntity(
      count: this?.count ?? Constants.zero,
      list: this?.list?.toDomain() ?? UserPaginationModel().toDomain(),
    );
  }
}
