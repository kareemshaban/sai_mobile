import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/settings_params/change_privacy_params.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class ChangePrivacyUseCase extends BaseUseCase<ChangePrivacyParams, dynamic> {
  final SettingsRepository _settingsRepository;
  ChangePrivacyUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, dynamic>> execute(ChangePrivacyParams params) async {
    return await _settingsRepository.changePrivacy(params);
  }
}
