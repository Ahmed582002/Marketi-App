import 'package:dio/dio.dart';
import 'package:store/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

ServerException handleDioExceptions(DioException e) {
  if (e.response != null && e.response!.data != null) {
    return ServerException(errModel: ErrorModel.fromJson(e.response!.data));
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return ServerException(
        errModel: ErrorModel(status: 408, errorMessage: "Connection timeout"),
      );

    case DioExceptionType.sendTimeout:
      return ServerException(
        errModel: ErrorModel(status: 408, errorMessage: "Send timeout"),
      );

    case DioExceptionType.receiveTimeout:
      return ServerException(
        errModel: ErrorModel(status: 408, errorMessage: "Receive timeout"),
      );

    case DioExceptionType.badCertificate:
      return ServerException(
        errModel: ErrorModel(status: 495, errorMessage: "Bad certificate"),
      );

    case DioExceptionType.cancel:
      return ServerException(
        errModel: ErrorModel(status: 499, errorMessage: "Request cancelled"),
      );

    case DioExceptionType.connectionError:
      return ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: "No internet connection",
        ),
      );

    case DioExceptionType.unknown:
      return ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: e.message ?? "Unknown error",
        ),
      );

    case DioExceptionType.badResponse:
      return ServerException(
        errModel: ErrorModel(
          status: e.response?.statusCode ?? 500,
          errorMessage: e.response?.data?["message"] ?? "Server error occurred",
        ),
      );
  }
}
