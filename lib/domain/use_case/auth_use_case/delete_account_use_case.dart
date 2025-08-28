import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class DeleteAccountUseCase extends BaseUseCase<dynamic, dynamic> {
  final AuthRepository _authRepository;
  DeleteAccountUseCase(this._authRepository);

  @override
  Future<Either<Failure, dynamic>> execute(params) async {
    return await _authRepository.deleteAccount();
  }
}
