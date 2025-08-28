import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/settings_entity/record_entity.dart';
import 'package:new_sai/domain/repository/wallet_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetBounceRecordsUseCase extends BaseUseCase<int, RecordPaginationEntity> {
  final WalletRepository _walletRepository;
  GetBounceRecordsUseCase(this._walletRepository);

  @override
  Future<Either<Failure, RecordPaginationEntity>> execute(int params) async {
    return await _walletRepository.getBounceRecords(params);
  }
}
