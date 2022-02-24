import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Request {
  static String _host = "http://192.168.1.18:3000/";

  Request() {}
  String get host {
    return _host;
  }

  static Future<String> get(String action,
      {dynamic params, int timeout: 5}) async {
    String message = "error";

    Uri uri = Uri.parse(_host + action);
    final newURI = uri.replace(queryParameters: params);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final response = await http
        .get(newURI, headers: headers)
        .timeout(Duration(seconds: timeout));

    if (response.statusCode == 200) {
      message = response.body;
    } else {
      message = "error";
    }
    return message;
  }

  static Future<String> put(String action, dynamic body) async {
    String message = "";
    final prefs = await SharedPreferences.getInstance();
    final String accessToken = prefs.getString('access_token');
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    if (accessToken != null) {
      headers.addAll({'Authorization': 'Bearer $accessToken'});
      print("Ho effettuato una richiesta con access_token =" + accessToken);
    }
    final response =
        await http.put(Uri.parse(_host + action), headers: headers, body: body);

    message = response.body;

    return message;
  }

  static Future<String> post(String action, dynamic body) async {
    String message;
    final prefs = await SharedPreferences.getInstance();
    final String accessToken = prefs.getString('access_token');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (accessToken != null) {
      headers.addAll({'Authorization': 'Bearer $accessToken'});
      // print("Ho effettuato una richiesta con access_token =" + accessToken);
    }
    final response = await http.post(Uri.parse(_host + action),
        headers: headers, body: jsonEncode(body));

    return response.body;
  }

  static Future<String> delete(String action) async {
    String message;
    final prefs = await SharedPreferences.getInstance();
    final String accessToken = prefs.getString('access_token');

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    if (accessToken != null) {
      headers.addAll({'Authorization': 'Bearer $accessToken'});
      // print("Ho effettuato una richiesta con access_token =" + accessToken);
    }
    final response =
        await http.delete(Uri.parse(_host + action), headers: headers);

    if (response.statusCode != 200) {
      dynamic res = json.decode(response.body);
      res['error'] = true;
      return json.encode(res);
    }
    return message;
  }
}
