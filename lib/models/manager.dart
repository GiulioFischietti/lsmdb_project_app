import 'package:eventi_in_zona/models/user.dart';

class Manager extends User {
  late int id;
  late String title;
  late DateTime hiredDate;

  Manager(data) : super(data) {
    id = data['id'];
    title = data['title'] ?? "";
    hiredDate = DateTime.parse(data['hired_date']);
  }
}
