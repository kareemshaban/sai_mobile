import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/chat_params/fetch_messages_params.dart';
import 'package:new_sai/domain/repository/chat_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class MarkAllAsReadUseCase extends BaseUseCase<FetchMessagesParams, dynamic> {
  final ChatRepository _chatRepository;
  MarkAllAsReadUseCase(this._chatRepository);

  @override
  Future<Either<Failure, dynamic>> execute(FetchMessagesParams params) async {
    return await _chatRepository.markAllAsRead(params);
  }
}
