import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/update_role_params.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class CancelMembershipUseCase extends BaseUseCase<UpdateRoleParams, dynamic> {
  final RoomRepository _roomRepository;
  CancelMembershipUseCase(this._roomRepository);

  @override
  Future<Either<Failure, dynamic>> execute(UpdateRoleParams params) async {
    return await _roomRepository.cancelMembership(params);
  }
}
