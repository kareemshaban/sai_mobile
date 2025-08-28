import 'package:new_sai/data/data_source/room_data_source/room_remote_data_source.dart';
import 'package:new_sai/data/repository/room_repository_impl.dart';
import 'package:new_sai/domain/repository/room_repository.dart';
import 'package:new_sai/domain/use_case/room_use_case/cancel_fire_user_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/cancel_membership_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/create_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/fire_user_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/generate_zego_token_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_famous_rooms_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_fire_user_list_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_gift_list_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_global_statistics_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_memper_rooms_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_my_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_popular_rooms_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_banners_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_by_country_id_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_gift_users_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_mempers_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_settings_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_user_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_users_in_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/join_as_member_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/join_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/leave_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/lock_mic_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/lock_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/send_room_gift_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/send_room_message_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/send_room_report_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/unlock_mic_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/unlock_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/update_room_settings_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/update_user_role_use_case.dart';

import 'basic_di.dart';

initRoomModule() {
  instance.registerLazySingleton<RoomRemoteDataSource>(
      () => RoomRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<RoomRepository>(() => RoomRepositoryImpl(
        instance(),
        instance(),
      ));

  instance.registerLazySingleton<GetMyRoomUseCase>(
      () => GetMyRoomUseCase(instance()));

  instance.registerLazySingleton<GetPopularRoomsUseCase>(
      () => GetPopularRoomsUseCase(instance()));

  instance.registerLazySingleton<GetFamousRoomsUseCase>(
      () => GetFamousRoomsUseCase(instance()));

  instance.registerLazySingleton<GetMemperRoomsUseCase>(
      () => GetMemperRoomsUseCase(instance()));

  instance.registerLazySingleton<GetRoomBannersUseCase>(
      () => GetRoomBannersUseCase(instance()));

  instance.registerLazySingleton<CreateRoomUseCase>(
      () => CreateRoomUseCase(instance()));

  instance.registerLazySingleton<JoinRoomUseCase>(
      () => JoinRoomUseCase(instance()));

  instance.registerLazySingleton<LeaveRoomUseCase>(
      () => LeaveRoomUseCase(instance()));

  instance.registerLazySingleton<GenerateZegoTokenUseCase>(
      () => GenerateZegoTokenUseCase(instance()));

  instance.registerLazySingleton<GetGiftListUseCase>(
      () => GetGiftListUseCase(instance()));

  instance.registerLazySingleton<GetRoomSettingsUseCase>(
      () => GetRoomSettingsUseCase(instance()));

  instance.registerLazySingleton<UpdateRoomSettingsUseCase>(
      () => UpdateRoomSettingsUseCase(instance()));

  instance.registerLazySingleton<SendRoomMessageUseCase>(
      () => SendRoomMessageUseCase(instance()));

  instance
      .registerLazySingleton<LockMicUseCase>(() => LockMicUseCase(instance()));

  instance.registerLazySingleton<UnlockMicUseCase>(
      () => UnlockMicUseCase(instance()));

  instance.registerLazySingleton<LockRoomUseCase>(
      () => LockRoomUseCase(instance()));

  instance.registerLazySingleton<UnlockRoomUseCase>(
      () => UnlockRoomUseCase(instance()));

  instance.registerLazySingleton<GetRoomMempersUseCase>(
      () => GetRoomMempersUseCase(instance()));

  instance.registerLazySingleton<FireUserUseCase>(
      () => FireUserUseCase(instance()));

  instance.registerLazySingleton<CancelFireUserUseCase>(
      () => CancelFireUserUseCase(instance()));

  instance.registerLazySingleton<GetFireUserListUseCase>(
      () => GetFireUserListUseCase(instance()));

  instance.registerLazySingleton<GetRoomUserUseCase>(
      () => GetRoomUserUseCase(instance()));

  instance.registerLazySingleton<UpdateUserRoleUseCase>(
      () => UpdateUserRoleUseCase(instance()));

  instance.registerLazySingleton<JoinAsMemberUseCase>(
      () => JoinAsMemberUseCase(instance()));

  instance.registerLazySingleton<CancelMembershipUseCase>(
      () => CancelMembershipUseCase(instance()));

  instance.registerLazySingleton<SendRoomReportUseCase>(
      () => SendRoomReportUseCase(instance()));

  instance.registerLazySingleton<GetUsersInRoomUseCase>(
      () => GetUsersInRoomUseCase(instance()));

  instance.registerLazySingleton<SendRoomGiftUseCase>(
      () => SendRoomGiftUseCase(instance()));

  instance.registerLazySingleton<GetRoomByCountryIdUseCase>(
      () => GetRoomByCountryIdUseCase(instance()));

  instance.registerLazySingleton<GetGlobalStatisticsUseCase>(
      () => GetGlobalStatisticsUseCase(instance()));

  instance.registerLazySingleton<GetRoomGiftUsersUseCase>(
      () => GetRoomGiftUsersUseCase(instance()));
}
