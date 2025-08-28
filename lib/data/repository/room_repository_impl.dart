import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_sai/data/data_source/room_data_source/room_remote_data_source.dart';
import 'package:new_sai/data/mapper/auth_mapper.dart';
import 'package:new_sai/data/mapper/room_mapper.dart';
import 'package:new_sai/data/network/error_handler.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/network/network_info.dart';
import 'package:new_sai/data/params/room_params/create_room_params.dart';
import 'package:new_sai/data/params/room_params/fire_user_params.dart';
import 'package:new_sai/data/params/room_params/generate_zego_token_params.dart';
import 'package:new_sai/data/params/room_params/global_statistics_params.dart';
import 'package:new_sai/data/params/room_params/lock_room_params.dart';
import 'package:new_sai/data/params/room_params/lock_unlock_mic_params.dart';
import 'package:new_sai/data/params/room_params/room_report_params.dart';
import 'package:new_sai/data/params/room_params/room_user_params.dart';
import 'package:new_sai/data/params/room_params/send_gift_params.dart';
import 'package:new_sai/data/params/room_params/send_message_params.dart';
import 'package:new_sai/data/params/room_params/update_role_params.dart';
import 'package:new_sai/data/params/room_params/update_room_settings_params.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/room_entity/gift_entity.dart';
import 'package:new_sai/domain/entity/room_entity/joined_room_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_banners_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_gift_users_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_message_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_pagination_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_settings_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_user_entity.dart';
import 'package:new_sai/domain/entity/room_entity/zego_token_entity.dart';
import 'package:new_sai/domain/repository/room_repository.dart';

class RoomRepositoryImpl extends RoomRepository {
  final NetworkInfo _networkInfo;
  final RoomRemoteDataSource _remoteDataSource;

  RoomRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, RoomEntity>> getMyRoom() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getMyRoom();
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
  Future<Either<Failure, RoomPaginationEntity>> getPopularRooms(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getPopularRooms(params);
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
  Future<Either<Failure, RoomPaginationEntity>> getFamousRooms(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getFamousRooms(params);
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
  Future<Either<Failure, RoomPaginationEntity>> getMemperRooms(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getMemperRooms(params);
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
  Future<Either<Failure, RoomBannersEntity>> getRoomBanners() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getRoomBanners();
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
  Future<Either<Failure, RoomEntity>> createRoom(
      CreateRoomParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.createRoom(params);
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
  Future<Either<Failure, JoinedRoomEntity>> joinRoom(String params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.joinRoom(params);
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
  Future<Either<Failure, dynamic>> leaveRoom(String params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.leaveRoom(params);
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
  Future<Either<Failure, ZegoTokenEntity>> generateZegoToken(
      GenerateZegoTokenParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.generateZegoToken(params);
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
  Future<Either<Failure, List<GiftEntity>>> getGiftList() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getGiftList();
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data?.map((e) => e.toDomain()).toList() ?? []);
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
  Future<Either<Failure, RoomSettingsEntity>> getRoomSettings(
      String params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getRoomSettings(params);
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
  Future<Either<Failure, JoinedRoomEntity>> updateRoomSettings(
      UpdateRoomSettingsParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updateRoomSettings(params);
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
  Future<Either<Failure, RoomMessageEntity>> sendRoomMessage(
      SendRoomMessageParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.sendRoomMessage(params);
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
  Future<Either<Failure, dynamic>> lockMic(LockUnlockMicParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.lockMic(params);
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
  Future<Either<Failure, dynamic>> unlockMic(LockUnlockMicParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.unlockMic(params);
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
  Future<Either<Failure, dynamic>> lockRoom(LockRoomParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.lockRoom(params);
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
  Future<Either<Failure, dynamic>> unlockRoom(String params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.unlockRoom(params);
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
  Future<Either<Failure, UserPaginationEntity>> getRoomMempers(
      dynamic params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getRoomMempers(params);
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
  Future<Either<Failure, dynamic>> fireUser(FireUserParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.fireUser(params);
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
  Future<Either<Failure, dynamic>> cancelFireUser(FireUserParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.cancelFireUser(params);
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
  Future<Either<Failure, List<UserEntity>>> fireUserList(String params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.fireUserList(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data?.map((e) => e.toDomain()).toList() ?? []);
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
  Future<Either<Failure, RoomUserEntity>> getRoomUser(
      RoomUserParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getRoomUser(params);
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
  Future<Either<Failure, dynamic>> updateUserRole(
      UpdateRoleParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updateUserRole(params);
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
  Future<Either<Failure, dynamic>> joinAsMember(String params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.joinAsMember(params);
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
  Future<Either<Failure, dynamic>> cancelMembership(
      UpdateRoleParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.cancelMembership(params);
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
  Future<Either<Failure, dynamic>> sendRoomReport(
      RoomReportParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.sendRoomReport(params);
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
  Future<Either<Failure, List<UserEntity>>> getUsersInRoom(
      List<String> params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getUsersInRoom(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data?.map((e) => e.toDomain()).toList() ?? []);
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
  Future<Either<Failure, dynamic>> sendRoomGift(SendGiftParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.sendRoomGift(params);
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
  Future<Either<Failure, RoomPaginationEntity>> getRoomByCountryId(
      dynamic params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getRoomByCountryId(params);
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
  Future<Either<Failure, List<UserEntity>>> getGlobalStatistics(
      GlobalStatisticsParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getGlobalStatistics(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data?.map((e) => e.toDomain()).toList() ?? []);
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
  Future<Either<Failure, RoomGiftUsersEntityPagination>> getRoomGiftUsers(
      Map<String, dynamic> params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getRoomGiftUsers(params);
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
}
