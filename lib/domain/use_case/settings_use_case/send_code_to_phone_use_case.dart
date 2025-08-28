import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/settings_params/change_email_phone_params.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class SendCodeToPhoneUseCase
    extends BaseUseCase<ChangeEmailPhoneParams, dynamic> {
  final SettingsRepository _settingsRepository;
  SendCodeToPhoneUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, dynamic>> execute(
      ChangeEmailPhoneParams params) async {
    return await _settingsRepository.sendCodeToPhone(params);
  }
}
