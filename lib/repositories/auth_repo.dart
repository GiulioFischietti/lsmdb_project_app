import 'package:eventi_in_zona/repositories/repo.dart';

Future<dynamic> logInData(String username, String password) async {
  return await Repo()
      .postData("auth/login", {"username": username, "password": password});
}

Future<dynamic> updateUserData(
    int id, String name, String username, String phone, String address) async {
  return await Repo().postData("auth/updateuser", {
    "id": id,
    "name": name,
    "username": username,
    "phone": phone,
    "address": address
  });
}

Future<bool> signUp(String username, String pwd, String name) async {
  final response = (await Repo().postData("auth/signup", {
    "username": username.replaceAll(" ", ""),
    "password": pwd,
    "name": name,
  }));
  print(response);
  return response['success'];
}

Future<bool> signUpAsManager(String username, String pwd, String name) async {
  return (await Repo().postData("auth/signupasamanager", {
    "username": username.replaceAll(" ", ""),
    "password": pwd,
    "name": name,
  }))['success'];
}

Future<dynamic> logInAsManagerData(String username, String password) async {
  return await Repo().postData(
      "auth/loginasmanager", {"username": username, "password": password});
}
