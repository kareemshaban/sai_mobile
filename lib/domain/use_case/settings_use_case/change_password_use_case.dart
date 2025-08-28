import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/settings_params/change_password_params.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class ChangePasswordUseCase extends BaseUseCase<ChangePasswordParams, dynamic> {
  final SettingsRepository _settingsRepository;
  ChangePasswordUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, dynamic>> execute(ChangePasswordParams params) async {
    return await _settingsRepository.changePassword(params);
  }
}
