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
      this.id = data['id'];
      this.name = data['name'];
      this.username = data['username'];
      this.surname = data['surname'];
      this.api_token = data['api_token'];
      this.email = data['email'];
      this.phone = data['phone'];
      this.birthday = DateTime.parse(data['birthday']);
      this.image = data['image'];
      this.gender = data['gender'];
      this.motto = data['biography'];
    }
  }

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(parsedJson);
  }
}
