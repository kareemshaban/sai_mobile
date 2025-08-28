import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/data_source/wallet_data_source/wallet_remote_data_source.dart';
import 'package:new_sai/data/repository/wallet_repository_imp.dart';
import 'package:new_sai/domain/repository/wallet_repository.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_bounce_records_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_gift_records_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_my_redeems_record_use_case.dart';
import 'package:new_sai/domain/use_case/wallet_use_case/get_charging_units_use_case.dart';
import 'package:new_sai/domain/use_case/wallet_use_case/withdraw_use_case.dart';

initWalletModule() {
  instance.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(instance()),
  );

  instance.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImp(instance(), instance()),
  );
  instance.registerLazySingleton<WithdrawUseCase>(
      () => WithdrawUseCase(instance()));
  instance.registerLazySingleton<GetGiftRecordsUseCase>(
    () => GetGiftRecordsUseCase(instance()),
  );

  instance.registerLazySingleton<GetBounceRecordsUseCase>(
    () => GetBounceRecordsUseCase(instance()),
  );

  instance.registerLazySingleton<GetMyRedeemsRecordUseCase>(
    () => GetMyRedeemsRecordUseCase(instance()),
  );
  instance.registerLazySingleton<GetChargingUnitsUseCase>(
    () => GetChargingUnitsUseCase(instance()),
  );
}
