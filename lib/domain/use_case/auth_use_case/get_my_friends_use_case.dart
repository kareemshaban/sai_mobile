import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetMyFriendsUseCase extends BaseUseCase<int, UserFriendEntity> {
  final AuthRepository _authRepository;
  GetMyFriendsUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserFriendEntity>> execute(params) async {
    return await _authRepository.getMyFriends(params);
  }
}
