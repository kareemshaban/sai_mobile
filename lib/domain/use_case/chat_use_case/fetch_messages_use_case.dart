import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/chat_params/fetch_messages_params.dart';
import 'package:new_sai/domain/entity/chat_entity/messages_entity.dart';
import 'package:new_sai/domain/repository/chat_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class FetchMessagesUseCase
    extends BaseUseCase<FetchMessagesParams, MessagesPaginationEntity> {
  final ChatRepository _chatRepository;
  FetchMessagesUseCase(this._chatRepository);

  @override
  Future<Either<Failure, MessagesPaginationEntity>> execute(
      FetchMessagesParams params) async {
    return await _chatRepository.fetchMessages(params);
  }
}
