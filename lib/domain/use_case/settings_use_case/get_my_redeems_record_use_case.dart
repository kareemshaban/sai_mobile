import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/settings_entity/redeems_record_entity.dart';
import 'package:new_sai/domain/repository/wallet_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetMyRedeemsRecordUseCase
    extends BaseUseCase<int, RedeemsRecordPaginationEntity> {
  final WalletRepository _walletRepository;
  GetMyRedeemsRecordUseCase(this._walletRepository);

  @override
  Future<Either<Failure, RedeemsRecordPaginationEntity>> execute(
      int params) async {
    return await _walletRepository.getMyRedeemsRecord(params);
  }
}
