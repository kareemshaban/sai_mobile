import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/chat_entity/my_conversations_entity.dart';
import 'package:new_sai/domain/repository/chat_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetMyConversationsUseCase
    extends BaseUseCase<int, MyConversationsEntityPagination> {
  final ChatRepository _chatRepository;
  GetMyConversationsUseCase(this._chatRepository);

  @override
  Future<Either<Failure, MyConversationsEntityPagination>> execute(
      int params) async {
    return await _chatRepository.getMyConversations(params);
  }
}
