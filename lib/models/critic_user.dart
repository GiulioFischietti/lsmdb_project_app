import 'package:eventi_in_zona/models/user_minimal.dart';
import 'package:objectid/objectid.dart';

class CriticUser {
  late UserMinimal userMinimal;
  late int nReviews;
  late double avg;
  late double criticScore;

  CriticUser(data) {
    userMinimal = UserMinimal(data['_id']);

    nReviews = data['nReviews'];
    avg = double.parse(data['avg'].toStringAsFixed(2));
    criticScore = double.parse(data['criticScore'].toStringAsFixed(2));
  }
}
