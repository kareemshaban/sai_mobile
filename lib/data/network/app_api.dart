import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';

abstract class AppServiceClient {
  AppServiceClient(Dio dio);

  Future<BaseMapModel<T>> performPutRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    data,
  );

  Future<BaseListModel<T>> performPutListRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    data,
  );

  Future<BaseMapModel<T>> performPatchRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    d.FormData? data,
  );

  Future<BaseMapModel<T>> performPatchRequestJSON<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic> data,
  );

  Future<BaseMapModel<T>> performPostRequest<T>(
    String endpoint,
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  );

  Future<BaseListModel<T>> performPostRequestList<T>(
    String endpoint,
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  );

  Future<BaseMapModel<T>> performDeleteRequest<T>(
    String endpoint, {
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<BaseListModel<T>> performDeleteListRequest<T>(
    String endpoint, {
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<dynamic> performDownloadRequest<T>(String url, String path);

  Future<BaseListModel<T>> performGetListRequest<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson,
      {Map<String, dynamic>? params});

  Future<BaseMapModel<T>> performGetRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? params,
  });
}

class AppServiceClientImpl extends AppServiceClient {
  final Dio dio;

  AppServiceClientImpl(this.dio) : super(dio);

  @override
  Future<BaseMapModel<T>> performGetRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? params,
    bool hasDataBody = true,
  }) async {
    final response = await dio.get(
      endpoint,
      queryParameters: params,
      options: GetOptions.getOptions(),
    );
    final value = BaseMapModel<T>.fromJson(
      response.data!,
      (json) => fromJson(json as Map<String, dynamic>),
    );

    return value;
  }

  @override
  Future<BaseListModel<T>> performGetListRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    String? listName,
    Map<String, dynamic>? params,
    bool hasDataKey = true,
  }) async {
    final response = await dio.get(
      endpoint,
      queryParameters: params,
      options: GetOptions.getOptions(),
    );

    final value = BaseListModel<T>.fromJson(
      response.data!,
      (json) => fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  Future<BaseMapModel<T>> performPostListRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    String? listName,
    data,
    Map<String, dynamic>? params,
  }) async {
    final response = await dio.post(
      endpoint,
      queryParameters: params,
      data: data,
      options: GetOptions.getOptions(),
    );

    final value = BaseMapModel<T>.fromJson(
      response.data!,
      (json) => fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseMapModel<T>> performPostRequest<T>(
    String endpoint,
    dynamic data,
    T Function(Map<String, dynamic>) fromJson, {
    bool isEmptyRequest = false,
    bool hasDataBody = true,
  }) async {
    final response = await dio.post(
      endpoint,
      data: data,
      options: GetOptions.getOptions(),
    );

    final value = BaseMapModel<T>.fromJson(
      response.data!,
      (json) => fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseMapModel<T>> performPutRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    data,
  ) async {
    final response = await dio.put(
      endpoint,
      data: data,
      options: GetOptions.getOptions(),
    );
    final value = BaseMapModel<T>.fromJson(
      response.data!,
      (json) => fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseMapModel<T>> performPatchRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    d.FormData? data,
  ) async {
    final response = await dio.patch(
      endpoint,
      data: data,
      options: GetOptions.getOptions(),
    );
    final value = BaseMapModel<T>.fromJson(
      response.data!,
      (json) => fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseMapModel<T>> performPatchRequestJSON<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? data,
  ) async {
    final response = await dio.patch(
      endpoint,
      data: data,
      options: GetOptions.getOptions(),
    );
    final value = BaseMapModel<T>.fromJson(
      response.data!,
      (json) => fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseMapModel<T>> performDeleteRequest<T>(String endpoint,
      {T Function(Map<String, dynamic>)? fromJson}) async {
    final response = await dio.delete(
      endpoint,
      options: GetOptions.getOptions(),
    );
    final value = BaseMapModel<T>.fromJson(
      response.data!,
      (json) => fromJson!(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<dynamic> performDownloadRequest<T>(String url, String path,
      {T Function(Map<String, dynamic>)? fromJson}) async {
    final response = await dio.download(url, path,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: const Duration(minutes: 2)));
    return response.data;
  }

  @override
  Future<BaseListModel<T>> performPostRequestList<T>(
    String endpoint,
    dynamic data,
    T Function(Map<String, dynamic> p1) fromJson,
  ) async {
    final response = await dio.post(
      endpoint,
      data: data,
      options: GetOptions.getOptions(),
    );

    final value = BaseListModel<T>.fromJson(
      response.data!,
      (json) => fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListModel<T>> performDeleteListRequest<T>(String endpoint,
      {T Function(Map<String, dynamic>)? fromJson}) async {
    final response = await dio.delete(
      endpoint,
      options: GetOptions.getOptions(),
    );
    final value = BaseListModel<T>.fromJson(
      response.data!,
      (json) => fromJson!(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListModel<T>> performPutListRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic> p1) fromJson,
    data,
  ) async {
    final response = await dio.put(
      endpoint,
      queryParameters: data,
      options: GetOptions.getOptions(),
    );
    final value = BaseListModel<T>.fromJson(
      response.data!,
      (json) => fromJson(json as Map<String, dynamic>),
    );
    return value;
  }
}

class GetOptions {
  static Options options = Options();
  static final AppPreferences _appPreferences = instance<AppPreferences>();
  static Options getOptions() {
    final token = _appPreferences.getUserToken();
    if (token.isNotEmpty) {
      options.headers = {
        'Accept': 'application/json',
        'Accept-Language': _appPreferences.getAppLanguage(),
        'Authorization': 'Bearer $token',
      };
    } else {
      options.headers = {
        'Accept': 'application/json',
        'Accept-Language': _appPreferences.getAppLanguage(),
      }; // default for non-auth
    }
    return options;
  }
}
