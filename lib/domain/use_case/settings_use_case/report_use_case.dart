import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/settings_params/report_params.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class ReportUseCase extends BaseUseCase<ReportParams, dynamic> {
  final SettingsRepository _settingsRepository;
  ReportUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, dynamic>> execute(ReportParams params) async {
    return await _settingsRepository.report(params);
  }
}
