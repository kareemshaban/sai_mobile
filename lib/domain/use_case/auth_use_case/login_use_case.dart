import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class LoginUseCase extends BaseUseCase<AuthParams, UserEntity> {
  final AuthRepository _authRepository;
  LoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> execute(AuthParams params) async {
    return await _authRepository.login(params);
  }
}
