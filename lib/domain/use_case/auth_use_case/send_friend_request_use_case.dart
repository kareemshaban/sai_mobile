import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class SendFriendRequestUseCase extends BaseUseCase<int, dynamic> {
  final AuthRepository _authRepository;
  SendFriendRequestUseCase(this._authRepository);

  @override
  Future<Either<Failure, dynamic>> execute(int params) async {
    return await _authRepository.sendFriendRequest(params);
  }
}
