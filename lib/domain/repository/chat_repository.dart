import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/chat_params/fetch_messages_params.dart';
import 'package:new_sai/data/params/chat_params/send_message_params.dart';
import 'package:new_sai/domain/entity/chat_entity/friend_request_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/messages_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/my_conversations_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, MyConversationsEntityPagination>> getMyConversations(
      int params);
  Future<Either<Failure, MessagesPaginationEntity>> fetchMessages(
      FetchMessagesParams params);
  Future<Either<Failure, dynamic>> markAllAsRead(FetchMessagesParams params);
  Future<Either<Failure, dynamic>> sendMessage(SendMessageParams params);
  Future<Either<Failure, dynamic>> deliveredMessage(int params);
  Future<Either<Failure, FriendRequestPaginationEntity>> getFriendRequest(
      int params);
  Future<Either<Failure, dynamic>> acceptFriendRequest(int params);
  Future<Either<Failure, dynamic>> removeFriendRequest(int params);
  Future<Either<Failure, dynamic>> deleteChat(int params);
}
