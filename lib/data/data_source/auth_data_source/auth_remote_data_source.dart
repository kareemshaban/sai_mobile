import 'package:dio/dio.dart';
import 'package:new_sai/data/model/auth_model/register_model.dart';
import 'package:new_sai/data/model/auth_model/user_model.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/end_point.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';

abstract class AuthRemoteDataSource {
  Future<BaseMapModel<UserModel>> login(AuthParams params);
  Future<BaseMapModel<RegisterModel>> registerVerification(AuthParams params);
  Future<BaseMapModel<RegisterModel>> verifyCode(AuthParams params);
  Future<BaseMapModel<UserModel>> register(AuthParams params);
  Future<BaseMapModel> forgetPassword(AuthParams params);
  Future<BaseMapModel> verifyForgetPassword(AuthParams params);
  Future<BaseMapModel> resetPassword(AuthParams params);
  Future<BaseMapModel<UserModel>> updateProfile(AuthParams params);
  Future<BaseMapModel<UserModel>> getMyProfile();
  Future<BaseListModel> logout();
  Future<BaseMapModel<UserModel>> getUserProfileByID(int params);
  Future<BaseMapModel> sendFriendRequest(int params);
  Future<BaseMapModel> cancelFriendRequest(int params);
  Future<BaseMapModel> deleteAccount();
  Future<BaseListModel> updateFcmToken(AuthParams params);
  Future<BaseMapModel<UserFriendModel>> getMyFriends(int param);
  Future<BaseMapModel<UserFriendModel>> getUsersType(
      Map<String, dynamic> param);
  Future<BaseMapModel<UserPaginationModel>> getMyVisitor(int param);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AppServiceClient _appServiceClient;

  AuthRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseMapModel<UserModel>> login(AuthParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.login,
      params.toJson(),
      UserModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<RegisterModel>> registerVerification(
      AuthParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.registerVerification,
      params.toJson(),
      RegisterModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<RegisterModel>> verifyCode(AuthParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.verifyCode,
      params.toJson(),
      RegisterModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<UserModel>> register(AuthParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.register,
      params.toJson(),
      UserModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> forgetPassword(AuthParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.forgetPassword,
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> verifyForgetPassword(AuthParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.verifyForgetPassword,
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> resetPassword(AuthParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.resetPassword,
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<UserModel>> updateProfile(AuthParams params) async {
    final data = FormData.fromMap(
      {
        if (params.name != null) 'name': params.name,
        if (params.birthDate != null) 'birth_date': params.birthDate,
        if (params.countryId != null) 'country_id': params.countryId,
        if (params.profileImg != null)
          'profile_img': await MultipartFile.fromFile(params.profileImg!),
        if (params.profileCover != null)
          'profile_cover': await MultipartFile.fromFile(params.profileCover!),
        if (params.gender != null) 'gender': params.gender,
        if (params.profileDescription != null)
          'profile_description': params.profileDescription,
      },
    );
    return await _appServiceClient.performPostRequest(
      EndPoint.updateProfile,
      data,
      UserModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<UserModel>> getMyProfile() async {
    return await _appServiceClient.performGetRequest(
      EndPoint.myProfile,
      UserModel.fromJson,
    );
  }

  @override
  Future<BaseListModel> logout() async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.logout,
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<UserModel>> getUserProfileByID(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.getUserProfileByID(params),
      UserModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> sendFriendRequest(int params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.sendFriendRequest,
      {
        'friend_id': params,
      },
      (p0) => null,
    );
  }

  @override
  Future<BaseMapModel> cancelFriendRequest(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.cancelFriendRequest(params),
      (p0) => null,
    );
  }

  @override
  Future<BaseMapModel> deleteAccount() async {
    return await _appServiceClient.performGetRequest(
      EndPoint.deleteAccount,
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<UserFriendModel>> getMyFriends(int param) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.allFriends,
      params: {"page": param},
      UserFriendModel.fromJson,
    );
  }

  @override
  Future<BaseListModel> updateFcmToken(AuthParams params) async {
    return await _appServiceClient.performPostRequestList(
      EndPoint.updateFcmToken,
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<UserPaginationModel>> getMyVisitor(int param) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.myVisitor,
      params: {"page": param},
      UserPaginationModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<UserFriendModel>> getUsersType(
      Map<String, dynamic> param) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.getUsersType(param['type']),
      params: {
        "page": param['page'],
      },
      UserFriendModel.fromJson,
    );
  }
}
