// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/View/Access/login.dart';

class LoginEmailResponse {
  bool error;
  String access_token;
  String message;

  LoginEmailResponse(data) {
    this.error = data['error'];
    this.message = data['message'] ?? "";
    this.access_token = data['access_token'];
  }

  factory LoginEmailResponse.fromJson(Map<String, dynamic> parsedJson) {
    return LoginEmailResponse(parsedJson);
  }
}
