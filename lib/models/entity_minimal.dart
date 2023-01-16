// ignore: file_names
import 'package:objectid/objectid.dart';

class EntityMinimal {
  late ObjectId id;
  String type = "";
  String image = "";
  late String name;

  EntityMinimal(data) {
    id = ObjectId.fromHexString(data['_id']);
    type = data['type'];
    image = "http://192.168.151.160:3000/images/" +
        ((data['image'] as String).replaceAll(".png", ".jpg") ??
            data['name'] + ".jpg");
    name = data['name'];
  }
}
