import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../services/storage/storage_service.dart';
import '../../utils/constants/api_enpoint.dart';
import '../../utils/constants/api_log.dart';
import '../../utils/constants/api_response_model.dart';
import '../../utils/constants/app_string.dart';
import 'package:mime/mime.dart';


class ApiService {
  static final Dio _dio = _getMyDio();

  /// ========== [ HTTP METHODS ] ========== ///
  static Future<ApiResponseModel> post(
      String url, {
        dynamic body,
        Map<String, String>? header,
      }) => _request(url, "POST", body: body, header: header);

  static Future<ApiResponseModel> get(
      String url, {
        Map<String, String>? header,
      }) => _request(url, "GET", header: header);

  static Future<ApiResponseModel> put(
      String url, {
        dynamic body,
        Map<String, String>? header,
      }) => _request(url, "PUT", body: body, header: header);

  static Future<ApiResponseModel> patch(
      String url, {
        dynamic body,
        Map<String, String>? header,
      }) => _request(url, "PATCH", body: body, header: header);

  static Future<ApiResponseModel> delete(
      String url, {
        dynamic body,
        Map<String, String>? header,
      }) => _request(url, "DELETE", body: body, header: header);

  static Future<ApiResponseModel> multipartImage(
      String url, {
        Map<String, String> header = const {},
        Map<String, String> body = const {},
        String method = "POST",
        List files = const [],
      }) async {
    FormData formData = FormData();

    for (var item in files) {
      String imageName = item['name'] ?? "image";
      String? imagePath = item['image'];
      if (imagePath != null && imagePath.isNotEmpty) {
        File file = File(imagePath);
        String extension = file.path.split('.').last.toLowerCase();
        String? mimeType = lookupMimeType(imagePath);
        formData.files.add(
          MapEntry(
            imageName,
            await MultipartFile.fromFile(
              imagePath,
              filename: "$imageName.$extension",
              contentType: mimeType != null
                  ? DioMediaType.parse(mimeType)
                  : DioMediaType.parse("image/jpeg"),
            ),
          ),
        );
      }
    }

    body.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    final headers = Map<String, String>.from(header);
    headers['Content-Type'] = 'multipart/form-data';

    return _request(url, method, body: formData, header: headers);
  }

  static Future<ApiResponseModel> multipart(
      String url, {
        Map<String, String> header = const {},
        Map<String, dynamic> body = const {},
        String method = "POST",
        String imageName = 'image',
        String? imagePath,
      }) async {
    FormData formData = FormData();
    if (imagePath != null && imagePath.isNotEmpty) {
      File file = File(imagePath);
      String extension = file.path.split('.').last.toLowerCase();
      String? mimeType = lookupMimeType(imagePath);

      formData.files.add(
        MapEntry(
          imageName,
          await MultipartFile.fromFile(
            imagePath,
            filename: "$imageName.$extension",
            contentType: mimeType != null
                ? DioMediaType.parse(mimeType)
                : DioMediaType.parse("image/jpeg"),
          ),
        ),
      );
    }

    body.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    final headers = Map<String, String>.from(header);
    headers['Content-Type'] = "multipart/form-data";

    return _request(url, method, body: formData, header: headers);
  }


  /// ========== [ MULTIPART FOR JSON + MULTIPLE FILES ] ========== ///
  static Future<ApiResponseModel> multipartRequest(
      String url, {
        Map<String, String> header = const {},
        required Map<String, dynamic> bodyData, // যেমন: {"data": storePayload}
        Map<String, File?> files = const {},   // যেমন: {"logo": file1, "coverImage": file2}
        String method = "POST",
      }) async {
    FormData formData = FormData();

    // ১. ফাইলগুলো ফরমডেটাতে যুক্ত করা
    for (var entry in files.entries) {
      String fieldName = entry.key;
      File? file = entry.value;

      if (file != null && await file.exists()) {
        String extension = file.path.split('.').last.toLowerCase();
        String? mimeType = lookupMimeType(file.path);

        formData.files.add(
          MapEntry(
            fieldName,
            await MultipartFile.fromFile(
              file.path,
              filename: "$fieldName.$extension",
              contentType: mimeType != null
                  ? DioMediaType.parse(mimeType)
                  : DioMediaType.parse("image/jpeg"),
            ),
          ),
        );
      }
    }

    // ২. মেইন বডি বা JSON ডাটা ফিল্ডগুলো ফরমডেটাতে যুক্ত করা
    bodyData.forEach((key, value) {
      if (value is Map || value is List) {
        // যদি অবজেক্ট বা লিস্ট হয়, তবে তা JSON স্ট্রিং হিসেবে রূপান্তর করে পাঠানো
        formData.fields.add(MapEntry(key, jsonEncode(value)));
      } else {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    final headers = Map<String, String>.from(header);
    headers['Content-Type'] = 'multipart/form-data';

    return _request(
      url,
      method,
      body: formData,
      header: headers,
      sendTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
    );
  }

  /// ========== [ API REQUEST HANDLER ] ========== ///
  static Future<ApiResponseModel> _request(
      String url,
      String method, {
        dynamic body,
        Map<String, String>? header,
        Duration? sendTimeout,
        Duration? receiveTimeout,
      }) async {
    try {
      final response = await _dio.request(
        url,
        data: body,
        options: Options(
          method: method,
          headers: header,
          sendTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
        ),
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static ApiResponseModel _handleResponse(Response response) {
    if (response.statusCode == 201) {
      return ApiResponseModel(200, response.data);
    }
    return ApiResponseModel(response.statusCode, response.data);
  }

  static ApiResponseModel _handleError(dynamic error) {
    try {
      return _handleDioException(error);
    } catch (e) {
      return ApiResponseModel(500, {});
    }
  }

  static ApiResponseModel _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        print("Timeout Error: ${error.message}");
        return ApiResponseModel(408, {"message": AppString.requestTimeOut});

      case DioExceptionType.badResponse:
        return ApiResponseModel(
          error.response?.statusCode,
          error.response?.data,
        );

      case DioExceptionType.connectionError:
        return ApiResponseModel(503, {
          "message": AppString.noInternetConnection,
        });

      default:
        return ApiResponseModel(400, {});
    }
  }
}

/// ========== [ DIO INSTANCE WITH INTERCEPTORS ] ========== ///
Dio _getMyDio() {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndPoint.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  dio.interceptors.add(apiLog());

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = LocalStorage.token;
        final isMultipart = options.data is FormData;
        options
          ..headers["Authorization"] ??= "Bearer ${LocalStorage.token}"
          ..headers["Content-Type"] ??= "application/json"
          ..connectTimeout = const Duration(seconds: 30)
          ..sendTimeout = isMultipart
              ? const Duration(minutes: 2)
              : const Duration(seconds: 30)
          ..receiveDataWhenStatusError = true
          ..responseType = ResponseType.json
          ..receiveTimeout = isMultipart
              ? const Duration(minutes: 2)
              : const Duration(seconds: 30)
          ..baseUrl = options.baseUrl.startsWith("http")
              ? ""
              : ApiEndPoint.baseUrl;


        debugPrint("--------------------------------------------------");
        debugPrint("🚀 API REQUEST [${options.method}] => URL: ${options.uri}");
        debugPrint("🔑 Token Sent: Bearer $token");
        debugPrint("📦 Request Headers: ${options.headers}");
        debugPrint("--------------------------------------------------");

        handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle Session Expired Error
        final data = response.data;
        if (data is Map && data['message'] == "Session Expired") {
          LocalStorage.removeAllPrefData();
          return;
        }
        handler.next(response);
      },
      onError: (error, handler) {
        // Handle Session Expired Error in Error Response
        final data = error.response?.data;
        if (data is Map && data['message'] == "Session Expired") {
          LocalStorage.removeAllPrefData();
          return;
        }
        handler.next(error);
      },
    ),
  );
  return dio;
}