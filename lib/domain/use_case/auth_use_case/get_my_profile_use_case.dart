import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetMyProfileUseCase extends BaseUseCase<dynamic, UserEntity> {
  final AuthRepository _authRepository;
  GetMyProfileUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> execute(dynamic params) async {
    return await _authRepository.getMyProfile();
  }
}
