import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/room_params/room_report_params.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class SendRoomReportUseCase extends BaseUseCase<RoomReportParams, dynamic> {
  final RoomRepository _roomRepository;
  SendRoomReportUseCase(this._roomRepository);

  @override
  Future<Either<Failure, dynamic>> execute(RoomReportParams params) async {
    return await _roomRepository.sendRoomReport(params);
  }
}
