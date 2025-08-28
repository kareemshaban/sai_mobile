import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/data_source/settings_data_source/settings_remote_data_source.dart';
import 'package:new_sai/data/repository/settings_repository_impl.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';
import 'package:new_sai/domain/use_case/settings_use_case/activate_premium_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/buy_settings_market_product_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/change_email_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/change_password_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/change_phone_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/change_privacy_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_premium_list_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_setting_market_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_settings_market_product_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_terms_privacy_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/renew_premium_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/report_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/select_settings_market_product_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/send_code_to_email_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/send_code_to_phone_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/update_language_use_case.dart';

initSettingsModule() {
  instance.registerLazySingleton<SettingsRemoteDataSource>(
    () => SettingsRemoteDataSourceImpl(instance()),
  );

  instance.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(instance(), instance()),
  );

  instance.registerLazySingleton<GetPremiumListUseCase>(
    () => GetPremiumListUseCase(instance()),
  );

  instance.registerLazySingleton<ActivatePremiumUseCase>(
    () => ActivatePremiumUseCase(instance()),
  );

  instance.registerLazySingleton<RenewPremiumUseCase>(
    () => RenewPremiumUseCase(instance()),
  );

  instance.registerLazySingleton<GetSettingMarketUseCase>(
    () => GetSettingMarketUseCase(instance()),
  );

  instance.registerLazySingleton<GetSettingsMarketProductUseCase>(
    () => GetSettingsMarketProductUseCase(instance()),
  );

  instance.registerLazySingleton<BuySettingsMarketProductUseCase>(
    () => BuySettingsMarketProductUseCase(instance()),
  );

  instance.registerLazySingleton<SelectSettingsMarketProductUseCase>(
    () => SelectSettingsMarketProductUseCase(instance()),
  );

  instance.registerLazySingleton<UpdateLanguageUseCase>(
    () => UpdateLanguageUseCase(instance()),
  );

  instance.registerLazySingleton<GetTermsPrivacyUseCase>(
    () => GetTermsPrivacyUseCase(instance()),
  );

  instance.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(instance()),
  );

  instance.registerLazySingleton<ChangeEmailUseCase>(
    () => ChangeEmailUseCase(instance()),
  );

  instance.registerLazySingleton<ChangePhoneUseCase>(
    () => ChangePhoneUseCase(instance()),
  );

  instance.registerLazySingleton<SendCodeToEmailUseCase>(
    () => SendCodeToEmailUseCase(instance()),
  );

  instance.registerLazySingleton<SendCodeToPhoneUseCase>(
    () => SendCodeToPhoneUseCase(instance()),
  );

  instance.registerLazySingleton<ReportUseCase>(
    () => ReportUseCase(instance()),
  );

  instance.registerLazySingleton<ChangePrivacyUseCase>(
    () => ChangePrivacyUseCase(instance()),
  );
}
