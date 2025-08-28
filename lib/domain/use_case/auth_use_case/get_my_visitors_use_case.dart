import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetMyVisitorsUseCase extends BaseUseCase<int, UserPaginationEntity> {
  final AuthRepository _authRepository;
  GetMyVisitorsUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserPaginationEntity>> execute(int params) async {
    return await _authRepository.getMyVisitors(params);
  }
}
