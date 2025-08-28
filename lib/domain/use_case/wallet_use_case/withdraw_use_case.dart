import 'package:dartz/dartz.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/wallet_params/withdraw_params.dart';
import 'package:new_sai/domain/repository/wallet_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class WithdrawUseCase extends BaseUseCase<WithdrawParams, BaseMapModel> {
  final WalletRepository _walletRepository;
  WithdrawUseCase(this._walletRepository);
  @override
  Future<Either<Failure, BaseMapModel>> execute(params) async {
    return await _walletRepository.withdrawRequest(params);
  }
}
