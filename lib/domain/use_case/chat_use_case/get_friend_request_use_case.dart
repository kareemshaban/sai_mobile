import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/chat_entity/friend_request_entity.dart';
import 'package:new_sai/domain/repository/chat_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetFriendRequestUseCase
    extends BaseUseCase<int, FriendRequestPaginationEntity> {
  final ChatRepository _chatRepository;
  GetFriendRequestUseCase(this._chatRepository);

  @override
  Future<Either<Failure, FriendRequestPaginationEntity>> execute(
      int params) async {
    return await _chatRepository.getFriendRequest(params);
  }
}
