import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetUsersTypeUseCase
    extends BaseUseCase<Map<String, dynamic>, UserFriendEntity> {
  final AuthRepository _authRepository;
  GetUsersTypeUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserFriendEntity>> execute(
      Map<String, dynamic> params) async {
    return await _authRepository.getUsersType(params);
  }
}
