import 'package:store/core/api/end_ponits.dart';

class ErrorModel {
  final int? status;
  final String errorMessage;

  ErrorModel({this.status, required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      status: jsonData[ApiKey.status] ?? jsonData['statusCode'],

      errorMessage:
          jsonData[ApiKey.errorMessage] ??
          jsonData['message'] ??
          jsonData['error'] ??
          "Unknown error",
    );
  }
}
