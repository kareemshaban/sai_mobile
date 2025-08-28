import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class UpdateLanguageUseCase extends BaseUseCase<String, bool> {
  final SettingsRepository _settingsRepository;
  UpdateLanguageUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, bool>> execute(String params) async {
    return await _settingsRepository.updateLanguagdde(params);
  }


}
