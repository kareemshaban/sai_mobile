import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_sai/data/data_source/chat_data_source/chat_remote_data_source.dart';
import 'package:new_sai/data/mapper/chat_mapper.dart';
import 'package:new_sai/data/network/error_handler.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/network/network_info.dart';
import 'package:new_sai/data/params/chat_params/fetch_messages_params.dart';
import 'package:new_sai/data/params/chat_params/send_message_params.dart';
import 'package:new_sai/domain/entity/chat_entity/friend_request_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/messages_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/my_conversations_entity.dart';
import 'package:new_sai/domain/repository/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;
  final NetworkInfo _networkInfo;

  ChatRepositoryImpl(
    this._networkInfo,
    this._chatRemoteDataSource,
  );

  @override
  Future<Either<Failure, MyConversationsEntityPagination>> getMyConversations(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _chatRemoteDataSource.getMyConversations(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, MessagesPaginationEntity>> fetchMessages(
      FetchMessagesParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _chatRemoteDataSource.fetchMessages(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> markAllAsRead(
      FetchMessagesParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _chatRemoteDataSource.markAllAsRead(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> sendMessage(SendMessageParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _chatRemoteDataSource.sendMessage(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> deliveredMessage(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _chatRemoteDataSource.deliveredMessage(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, FriendRequestPaginationEntity>> getFriendRequest(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _chatRemoteDataSource.getFriendRequest(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> acceptFriendRequest(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _chatRemoteDataSource.acceptFriendRequest(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> removeFriendRequest(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _chatRemoteDataSource.removeFriendRequest(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteChat(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _chatRemoteDataSource.deleteChat(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
