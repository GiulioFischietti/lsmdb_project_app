import 'package:eventi_in_zona/models/user.dart';

class Customer extends User {
  late int id;
  late int userId;
  late String country;
  late String address;
  late String phone;

  Customer(data) : super(data) {
    id = data['id'] ?? 0;
    print("CUSTOMER.ID $id");
    userId = data['user_id'] ?? 0;
    print("CUSTOMER.user_id $userId");
    country = data['country'] ?? "";
    address = data['address'] ?? "";
    phone = data['phone'] ?? "";
  }
}
