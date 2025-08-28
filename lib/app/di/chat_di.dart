import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/data_source/chat_data_source/chat_remote_data_source.dart';
import 'package:new_sai/data/repository/chat_repository_impl.dart';
import 'package:new_sai/domain/repository/chat_repository.dart';
import 'package:new_sai/domain/use_case/chat_use_case/accept_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/delete_chat_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/delivered_message_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/fetch_messages_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/get_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/get_my_conversations_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/mark_all_as_read_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/remove_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/send_message_use_case.dart';

initChatModule() {
  instance.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(instance()),
  );

  instance.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(instance(), instance()),
  );

  instance.registerLazySingleton<GetMyConversationsUseCase>(
    () => GetMyConversationsUseCase(instance()),
  );

  instance.registerLazySingleton<FetchMessagesUseCase>(
    () => FetchMessagesUseCase(instance()),
  );

  instance.registerLazySingleton<MarkAllAsReadUseCase>(
    () => MarkAllAsReadUseCase(instance()),
  );

  instance.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(instance()),
  );

  instance.registerLazySingleton<DeliveredMessageUseCase>(
    () => DeliveredMessageUseCase(instance()),
  );

  instance.registerLazySingleton<GetFriendRequestUseCase>(
    () => GetFriendRequestUseCase(instance()),
  );

  instance.registerLazySingleton<AcceptFriendRequestUseCase>(
    () => AcceptFriendRequestUseCase(instance()),
  );

  instance.registerLazySingleton<RemoveFriendRequestUseCase>(
    () => RemoveFriendRequestUseCase(instance()),
  );

  instance.registerLazySingleton<DeleteChatUseCase>(
    () => DeleteChatUseCase(instance()),
  );
}
