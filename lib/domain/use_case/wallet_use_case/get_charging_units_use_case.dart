import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/wallet_entity/units_entity.dart';
import 'package:new_sai/domain/repository/wallet_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetChargingUnitsUseCase extends BaseUseCase<dynamic, UnitEntity> {
  final WalletRepository repository;
  GetChargingUnitsUseCase(this.repository);
  @override
  Future<Either<Failure, UnitEntity>> execute(dynamic params) async {
    return await repository.getChargingUnits();
  }
}
