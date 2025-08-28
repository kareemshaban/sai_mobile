import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

import 'failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unProcessableEntity,
  unknown
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.successApi,
        );
      case DataSource.noContent:
        return Failure(
          code: ResponseCode.noContent,
          message: ResponseMessage.noContent,
        );
      case DataSource.badRequest:
        return Failure(
          code: ResponseCode.badRequest,
          message: ResponseMessage.badRequest,
        );
      case DataSource.forbidden:
        return Failure(
          code: ResponseCode.forbidden,
          message: ResponseMessage.forbidden,
        );
      case DataSource.unAuthorised:
        return Failure(
          code: ResponseCode.unauthorized,
          message: ResponseMessage.unauthorized,
        );
      case DataSource.notFound:
        return Failure(
          code: ResponseCode.notFound,
          message: ResponseMessage.notFound,
        );
      case DataSource.internalServerError:
        return Failure(
          code: ResponseCode.internalServerError,
          message: ResponseMessage.internalServerError,
        );
      case DataSource.connectTimeOut:
        return Failure(
          code: ResponseCode.connectTimeOut,
          message: ResponseMessage.connectTimeOut,
        );
      case DataSource.cancel:
        return Failure(
          code: ResponseCode.cancel,
          message: ResponseMessage.cancelApi,
        );
      case DataSource.receiveTimeOut:
        return Failure(
          code: ResponseCode.receiveTimeout,
          message: ResponseMessage.receiveTimeout,
        );
      case DataSource.sendTimeOut:
        return Failure(
          code: ResponseCode.sendTimeOut,
          message: ResponseMessage.sendTimeOut,
        );
      case DataSource.cacheError:
        return Failure(
          code: ResponseCode.cacheError,
          message: ResponseMessage.cacheError,
        );
      case DataSource.noInternetConnection:
        return Failure(
          code: ResponseCode.noInternetConnecting,
          message: ResponseMessage.noInternetConnecting,
        );
      case DataSource.unknown:
        return Failure(
          code: ResponseCode.unknown,
          message: ResponseMessage.unknown,
        );
      case DataSource.unProcessableEntity:
        return Failure(
            code: ResponseCode.unProcessableEntity,
            message: ResponseMessage.unProcessableEntity);
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  final AppPreferences appPreferences = instance<AppPreferences>();
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeOut.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeOut.getFailure();
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.unknown:
      return DataSource.unknown.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.unknown.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.badResponse:
      // if (error.response?.statusCode == ResponseCode.badRequest) {
      //   return DataSource.badRequest.getFailure();
      // } else
      if (error.response?.statusCode == ResponseCode.forbidden) {
        return DataSource.forbidden.getFailure();
      } else if (error.response?.statusCode == ResponseCode.unauthorized) {
        appPreferences.logout();
        if (Get.currentRoute != AppRoutes.loginRegisterRoute) {
          Get.offAllNamed(AppRoutes.loginRegisterRoute);
        }
        return DataSource.unAuthorised.getFailure();
      } else if (error.response?.statusCode == ResponseCode.notFound) {
        return DataSource.notFound.getFailure();
      } else if (error.response?.statusCode ==
          ResponseCode.internalServerError) {
        return DataSource.internalServerError.getFailure();
      } else if (error.response?.statusCode ==
              ResponseCode.unProcessableEntity ||
          error.response?.statusCode == ResponseCode.badRequest) {
        if (error.response?.data != null) {
          if (error.response?.data['message'] != null) {
            return Failure(
                code: ResponseCode.unProcessableEntity,
                message: error.response?.data['message']);
          } else {
            return DataSource.unProcessableEntity.getFailure();
          }
        } else {
          return DataSource.unProcessableEntity.getFailure();
        }
      } else {
        return DataSource.unknown.getFailure();
      }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int unProcessableEntity = 422;
  static const int internalServerError = 500;

  // local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnecting = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static String successApi = AppStrings.successApi;
  static String noContent = AppStrings.noContent;
  static String badRequest = AppStrings.badRequest;
  static String forbidden = AppStrings.forbidden;
  static String unauthorized = AppStrings.unauthorized;
  static String notFound = AppStrings.notFound;
  static String unProcessableEntity = AppStrings.unProcessableEntity;
  static String internalServerError = AppStrings.internalServerError;

  // local status code
  static String connectTimeOut = AppStrings.connectTimeOut;
  static String cancelApi = AppStrings.cancelApi;
  static String receiveTimeout = AppStrings.receiveTimeout;
  static String sendTimeOut = AppStrings.sendTimeOut;
  static String cacheError = AppStrings.cacheError;
  static String noInternetConnecting = AppStrings.noInternetConnecting;
  static String unknown = AppStrings.unknown;
}

class ApiInternalStatus {
  static const bool success = true;
}
