import 'package:dartz/dartz.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/entity/auth_entity/register_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(AuthParams params);
  Future<Either<Failure, RegisterEntity>> registerVerification(
      AuthParams params);
  Future<Either<Failure, RegisterEntity>> verifyCode(AuthParams params);
  Future<Either<Failure, UserEntity>> register(AuthParams params);
  Future<Either<Failure, BaseMapModel>> forgetPassword(AuthParams params);
  Future<Either<Failure, BaseMapModel>> verifyForgetPassword(AuthParams params);
  Future<Either<Failure, BaseMapModel>> resetPassword(AuthParams params);
  Future<Either<Failure, UserEntity>> updateProfile(AuthParams params);
  Future<Either<Failure, UserEntity>> getMyProfile();
  Future<Either<Failure, dynamic>> logout();
  Future<Either<Failure, UserEntity>> getUserProfileByID(int params);
  Future<Either<Failure, dynamic>> sendFriendRequest(int params);
  Future<Either<Failure, dynamic>> cancelFriendRequest(int params);
  Future<Either<Failure, dynamic>> deleteAccount();
  Future<Either<Failure, dynamic>> updateFcmToken(AuthParams params);
  Future<Either<Failure, UserFriendEntity>> getMyFriends(int param);
  Future<Either<Failure, UserFriendEntity>> getUsersType(
      Map<String, dynamic> params);
  Future<Either<Failure, UserPaginationEntity>> getMyVisitors(int param);
}
