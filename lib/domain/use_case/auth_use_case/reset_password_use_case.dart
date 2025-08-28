import 'package:dartz/dartz.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class ResetPasswordUseCase extends BaseUseCase<AuthParams, BaseMapModel> {
  final AuthRepository _authRepository;
  ResetPasswordUseCase(this._authRepository);

  @override
  Future<Either<Failure, BaseMapModel>> execute(AuthParams params) async {
    return await _authRepository.resetPassword(params);
  }
}
