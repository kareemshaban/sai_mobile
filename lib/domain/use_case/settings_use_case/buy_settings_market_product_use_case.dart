import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/settings_entity/settings_market_product_entity.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class BuySettingsMarketProductUseCase
    extends BaseUseCase<int, SettingsMarketProductEntity> {
  final SettingsRepository _settingsRepository;
  BuySettingsMarketProductUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, SettingsMarketProductEntity>> execute(
      int params) async {
    return await _settingsRepository.buySettingsMarketProduct(params);
  }
}
