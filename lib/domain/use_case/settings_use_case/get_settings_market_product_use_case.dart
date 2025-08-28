import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/settings_params/get_settings_product_params.dart';
import 'package:new_sai/domain/entity/settings_entity/settings_market_product_entity.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetSettingsMarketProductUseCase extends BaseUseCase<
    GetSettingsProductParams, List<SettingsMarketProductEntity>> {
  final SettingsRepository _settingsRepository;
  GetSettingsMarketProductUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, List<SettingsMarketProductEntity>>> execute(
      GetSettingsProductParams params) async {
    return await _settingsRepository.getSettingsMarketProduct(params);
  }
}
