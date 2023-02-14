import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Repo {
  Future<dynamic> getData(String query) async {
    final prefs = await SharedPreferences.getInstance();
    String host = prefs.getString("host")! + ':3000/';
    final response = await http.get(
      Uri.parse(host + query),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      var loginResponse = json.decode(response.body);
      // print(loginResponse);
      return loginResponse;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

      throw Exception('Failed to load');
    }
  }

  Future<dynamic> postData(String path, dynamic body) async {
    final prefs = await SharedPreferences.getInstance();
    String host = prefs.getString("host")! + ':3000/';
    final response = await http.post(Uri.parse(host + path),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    // print(response);
    if (response.statusCode == 200) {
      var loginResponse = json.decode(response.body);
      // print(loginResponse);
      // print(loginResponse);
      return loginResponse;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      throw Exception('Failed to load');
    }
  }
}
