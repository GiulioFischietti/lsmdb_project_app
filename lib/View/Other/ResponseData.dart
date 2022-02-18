import 'package:http/http.dart';
// ignore_for_file: file_names

class ResponseData {
  bool error;
  String message;

  ResponseData(data) {
    this.error = data['error'];
    this.message = data['message'];
  }

  factory ResponseData.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseData(parsedJson);
  }
}
