import 'package:new_sai/app/constants.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/mapper/chat_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/chat_model/chat_user_info_model.dart';
import 'package:new_sai/data/model/post_model/post_data_model.dart';
import 'package:new_sai/data/model/story_model/story_model.dart';
import 'package:new_sai/domain/entity/stories_entity/post_data_entity.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';

extension PostDataMapper on PostDataModel? {
  PostDataEntity toDomain() {
    return PostDataEntity(
      mediaPathList: this?.mediaPathList ?? [],
      textContent: this?.textContent ?? "",
    );
  }
}

extension StoryPaginationMapper on StoryPaginationModel? {
  StoryPaginationEntity toDomain() {
    return StoryPaginationEntity(
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
    );
  }
}

extension StoryMapper on StoryModel? {
  StoryEntity toDomain() {
    return StoryEntity(
      id: this?.id ?? Constants.zero,
      user: this?.user?.toDomain() ?? ChatUserInfoModel().toDomain(),
      media: this?.media?.map((e) => e.toDomain()).toList() ?? [],
      createdAt: this?.createdAt ?? Constants.empty,
      isComment: this?.isComment == 1,
      music: this?.music ?? Constants.empty,
      location: this?.location ?? Constants.empty,
      link: this?.link ?? Constants.empty,
      tag: this?.tag ?? [],
      title: this?.title ?? Constants.empty,
      description: this?.description ?? Constants.empty,
    );
  }
}

extension StoryMediaMapper on StoryMediaModel? {
  StoryMediaEntity toDomain() {
    return StoryMediaEntity(
      id: this?.id ?? Constants.zero,
      type: this?.type ?? Constants.empty,
      url: this?.url ?? Constants.empty,
      countShare: this?.countShare ?? Constants.zero,
      countViews: this?.countViews ?? Constants.zero,
      countComments: this?.countComments ?? Constants.zero,
      isFriend: this?.isFriend == 1,
      isSave: this?.isSave == 1,
      isLike: this?.isLike == 1,
      isView: this?.isView == 1,
      thump: this?.thump ?? Constants.empty,
    );
  }
}
