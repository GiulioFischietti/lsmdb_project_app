import 'package:objectid/objectid.dart';

class UserMinimal {
  late ObjectId id;
  late String username;
  late String image;

  UserMinimal(data) {
    id = ObjectId.fromHexString(data['_id']);
    username = data['username'];
    image = data['image'];
  }
}
