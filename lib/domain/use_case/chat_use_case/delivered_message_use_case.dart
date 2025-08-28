import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/chat_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class DeliveredMessageUseCase extends BaseUseCase<int, dynamic> {
  final ChatRepository _chatRepository;
  DeliveredMessageUseCase(this._chatRepository);

  @override
  Future<Either<Failure, dynamic>> execute(int params) async {
    return await _chatRepository.deliveredMessage(params);
  }
}
