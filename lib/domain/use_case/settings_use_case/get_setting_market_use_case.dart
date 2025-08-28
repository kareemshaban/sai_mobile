import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/settings_entity/setting_market_entity.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetSettingMarketUseCase
    extends BaseUseCase<dynamic, SettingMarketEntity> {
  final SettingsRepository _settingsRepository;
  GetSettingMarketUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, SettingMarketEntity>> execute(params) async {
    return await _settingsRepository.getSettingMarket();
  }
}
