// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
class UserModel {
  int id;
  String name;
  String surname;
  String email;
  String role;
  String backend_role;
  String username;
  String street;
  String street_number;
  int city;
  int cap;
  String phone;
  String image;
  String gender;
  DateTime birthday;
  int relation_id;
  int profession_id;
  String motto;
  String api_token;

  UserModel(data) {
    if (data != null) {
      this.id = data['id'] ?? 0;
      this.name = data['name'] ?? "";
      this.username = data['username'] ?? "";
      this.surname = data['surname'] ?? "";
      this.api_token = data['api_token'] ?? "";
      this.email = data['email'] ?? "";
      this.phone = data['phone'] ?? "";
      this.birthday =
          data['birthday'] != null ? DateTime.parse(data['birthday']) : null;
      this.image = data['image'] ??
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
      this.gender = data['gender'] ?? "";
      this.motto = data['motto'] ?? "";
    }
  }

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(parsedJson);
  }
}
