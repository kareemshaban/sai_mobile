import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class UpdateFcmTokenUseCase extends BaseUseCase<AuthParams, dynamic> {
  final AuthRepository _authRepository;
  UpdateFcmTokenUseCase(this._authRepository);

  @override
  Future<Either<Failure, dynamic>> execute(AuthParams params) async {
    return await _authRepository.updateFcmToken(params);
  }
}
