import 'package:eventi_in_zona/models/entity_minimal.dart';
import 'package:eventi_in_zona/models/user_minimal.dart';
import 'package:objectid/objectid.dart';

class Review {
  late ObjectId id;
  late String description;
  late int rate;
  late DateTime createdAt;
  late DateTime updatedAt;
  late EntityMinimal entity;
  late UserMinimal user;

  Review(data) {
    id = ObjectId.fromHexString(data['_id']);
    description = data['description'];
    rate = data['rate'];
    createdAt = DateTime.parse(data['createdAt']);
    updatedAt = DateTime.parse(data['updatedAt'] ?? data['createdAt']);
    // entity = EntityMinimal(data['entity']);
    user = UserMinimal(data['user']);
  }
}
