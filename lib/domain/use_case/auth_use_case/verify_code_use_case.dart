import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/entity/auth_entity/register_entity.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class VerifyCodeUseCase extends BaseUseCase<AuthParams, RegisterEntity> {
  final AuthRepository _authRepository;

  VerifyCodeUseCase(this._authRepository);

  @override
  Future<Either<Failure, RegisterEntity>> execute(AuthParams params) async {
    return await _authRepository.verifyCode(params);
  }
}
