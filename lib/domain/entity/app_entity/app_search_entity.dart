import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';

class AppSearchEntity {
  List<ReelsEntity> videos;
  List<String> hashTags;
  List<UserEntity> users;

  AppSearchEntity({
    required this.videos,
    required this.hashTags,
    required this.users,
  });
}
