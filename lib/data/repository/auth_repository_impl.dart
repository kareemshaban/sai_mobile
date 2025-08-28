import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_sai/data/data_source/auth_data_source/auth_remote_data_source.dart';
import 'package:new_sai/data/mapper/auth_mapper.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/error_handler.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/network/network_info.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/entity/auth_entity/register_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo _networkInfo;
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, UserEntity>> login(AuthParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.login(params);
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
  Future<Either<Failure, RegisterEntity>> registerVerification(
      AuthParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _authRemoteDataSource.registerVerification(params);
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
  Future<Either<Failure, RegisterEntity>> verifyCode(AuthParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.verifyCode(params);
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
  Future<Either<Failure, UserEntity>> register(AuthParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.register(params);
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
  Future<Either<Failure, BaseMapModel>> forgetPassword(
      AuthParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.forgetPassword(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response);
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
  Future<Either<Failure, BaseMapModel>> verifyForgetPassword(
      AuthParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _authRemoteDataSource.verifyForgetPassword(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response);
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
  Future<Either<Failure, BaseMapModel>> resetPassword(AuthParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.resetPassword(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response);
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
  Future<Either<Failure, UserEntity>> updateProfile(AuthParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.updateProfile(params);
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
  Future<Either<Failure, UserEntity>> getMyProfile() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.getMyProfile();
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
  Future<Either<Failure, dynamic>> logout() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.logout();
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
  Future<Either<Failure, UserEntity>> getUserProfileByID(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.getUserProfileByID(params);
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
  Future<Either<Failure, dynamic>> sendFriendRequest(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.sendFriendRequest(params);
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
  Future<Either<Failure, dynamic>> cancelFriendRequest(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _authRemoteDataSource.cancelFriendRequest(params);
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
  Future<Either<Failure, dynamic>> deleteAccount() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.deleteAccount();
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
  Future<Either<Failure, UserFriendEntity>> getMyFriends(int param) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.getMyFriends(param);
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
  Future<Either<Failure, dynamic>> updateFcmToken(AuthParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.updateFcmToken(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right("");
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
  Future<Either<Failure, UserPaginationEntity>> getMyVisitors(int param) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.getMyVisitor(param);
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
  Future<Either<Failure, UserFriendEntity>> getUsersType(
      Map<String, dynamic> params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.getUsersType(params);
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
