import 'package:new_sai/app/constants.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/mapper/auth_mapper.dart';
import 'package:new_sai/data/mapper/chat_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/chat_model/chat_user_info_model.dart';
import 'package:new_sai/data/model/reels_model/reels_comment_model.dart';
import 'package:new_sai/data/model/reels_model/reels_model.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';

extension ReelsPaginationMapper on ReelsPaginationModel? {
  ReelsPaginationEntity toDomain() {
    return ReelsPaginationEntity(
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
    );
  }
}

extension ReelsMapper on ReelsModel? {
  ReelsEntity toDomain() {
    return ReelsEntity(
      id: this?.id ?? Constants.zero,
      user: this?.user?.toDomain() ?? ChatUserInfoModel().toDomain(),
      createdAt: this?.createdAt ?? Constants.empty,
      description: this?.description ?? Constants.empty,
      video: this?.video ?? Constants.empty,
      countComments: this?.countComments ?? Constants.zero,
      countShare: this?.countShare ?? Constants.zero,
      countViews: this?.countViews ?? Constants.zero,
      isComment: this?.isComment == 1,
      isFollow: this?.isFollow == 1,
      location: this?.location ?? Constants.empty,
      tag: this?.tag ?? <String>[],
      isLike: this?.isLike == 1,
      countLikes: this?.countLikes ?? Constants.zero,
      countSaves: this?.countSaves ?? Constants.zero,
      isSave: this?.isSave == 1,
      isView: this?.isView == 1,
      mentions: this?.mentions?.map((e) => e.toDomain()).toList() ?? [],
      isFriend: this?.isFriend == 1,
      thumb: this?.thumb ?? Constants.empty,
      media: this?.media?.map((e) => e.toDomain()).toList() ?? [],
      music: this?.music ?? Constants.empty,
      isFollowing: this?.isFollowing == 1,
    );
  }
}

extension ReelsCommentPaginationMapper on ReelsCommentPaginationModel? {
  ReelsCommentPaginationEntity toDomain() {
    return ReelsCommentPaginationEntity(
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
    );
  }
}

extension ReelsCommentMapper on ReelsCommentModel? {
  ReelsCommentEntity toDomain() {
    return ReelsCommentEntity(
      id: this?.id ?? Constants.zero,
      comment: this?.comment ?? Constants.empty,
      user: this?.user?.toDomain() ?? ChatUserInfoModel().toDomain(),
      createdAt: this?.createdAt ?? Constants.empty,
    );
  }
}

extension ReelsMediaMapper on ReelsMediaModel? {
  ReelsMediaEntity toDomain() {
    return ReelsMediaEntity(
      id: this?.id ?? Constants.zero,
      url: this?.url ?? Constants.empty,
      type: this?.type ?? Constants.empty,
      thump: this?.thump ?? Constants.empty,
    );
  }
}
