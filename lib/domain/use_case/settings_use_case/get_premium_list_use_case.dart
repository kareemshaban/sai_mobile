import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/settings_entity/premium_entity.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetPremiumListUseCase extends BaseUseCase<dynamic, PremiumEntity> {
  final SettingsRepository _settingsRepository;
  GetPremiumListUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, PremiumEntity>> execute(params) async {
    return await _settingsRepository.getPremiumList();
  }
}
