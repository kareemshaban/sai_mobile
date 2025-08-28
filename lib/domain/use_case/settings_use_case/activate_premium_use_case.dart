import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class ActivatePremiumUseCase extends BaseUseCase<int, dynamic> {
  final SettingsRepository _settingsRepository;
  ActivatePremiumUseCase(this._settingsRepository);

  @override
  Future<Either<Failure, dynamic>> execute(int params) async {
    return await _settingsRepository.activatePremiuem(params);
  }
}
