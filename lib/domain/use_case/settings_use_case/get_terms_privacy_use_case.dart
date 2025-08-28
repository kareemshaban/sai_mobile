import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/settings_entity/terms_privacy_entity.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetTermsPrivacyUseCase extends BaseUseCase<int, TermsPrivacyEntity> {
  final SettingsRepository _settingsRepository;
  GetTermsPrivacyUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, TermsPrivacyEntity>> execute(int params) async {
    return await _settingsRepository.getTermsAndPrivacy(params);
  }
}
