import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/chat_params/send_message_params.dart';
import 'package:new_sai/domain/repository/chat_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class SendMessageUseCase extends BaseUseCase<SendMessageParams, dynamic> {
  final ChatRepository _chatRepository;
  SendMessageUseCase(this._chatRepository);

  @override
  Future<Either<Failure, dynamic>> execute(SendMessageParams params) async {
    return await _chatRepository.sendMessage(params);
  }
}
