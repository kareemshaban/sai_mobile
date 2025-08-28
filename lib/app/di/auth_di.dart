import 'package:new_sai/data/data_source/auth_data_source/auth_remote_data_source.dart';
import 'package:new_sai/data/repository/auth_repository_impl.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';
import 'package:new_sai/domain/use_case/auth_use_case/cancel_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/delete_account_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/forget_password_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_my_friends_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_my_profile_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_my_visitors_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_user_profile_by_id_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_users_type_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/login_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/logout_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/register_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/register_verification_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/reset_password_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/send_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/update_fcm_token_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/update_profile_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/verify_code_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/verify_forget_password_use_case.dart';

import 'basic_di.dart';

initAuthModule() {
  instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        instance(),
        instance(),
      ));

  instance.registerLazySingleton<LoginUseCase>(() => LoginUseCase(instance()));

  instance.registerLazySingleton<RegisterVerificationUseCase>(
      () => RegisterVerificationUseCase(instance()));

  instance.registerLazySingleton<VerifyCodeUseCase>(
      () => VerifyCodeUseCase(instance()));

  instance.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(instance()));

  instance.registerLazySingleton<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(instance()));

  instance.registerLazySingleton<VerifyForgetPasswordUseCase>(
      () => VerifyForgetPasswordUseCase(instance()));

  instance.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(instance()));

  instance.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(instance()));

  instance.registerLazySingleton<GetMyProfileUseCase>(
      () => GetMyProfileUseCase(instance()));

  instance
      .registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(instance()));

  instance.registerLazySingleton<GetUserProfileByIdUseCase>(
      () => GetUserProfileByIdUseCase(instance()));

  instance.registerLazySingleton<SendFriendRequestUseCase>(
      () => SendFriendRequestUseCase(instance()));

  instance.registerLazySingleton<CancelFriendRequestUseCase>(
      () => CancelFriendRequestUseCase(instance()));

  instance.registerLazySingleton<DeleteAccountUseCase>(
      () => DeleteAccountUseCase(instance()));

  instance.registerLazySingleton<GetMyFriendsUseCase>(
      () => GetMyFriendsUseCase(instance()));

  instance.registerLazySingleton<UpdateFcmTokenUseCase>(
      () => UpdateFcmTokenUseCase(instance()));

  instance.registerLazySingleton<GetMyVisitorsUseCase>(
      () => GetMyVisitorsUseCase(instance()));

  instance.registerLazySingleton<GetUsersTypeUseCase>(
      () => GetUsersTypeUseCase(instance()));
}
