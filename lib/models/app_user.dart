import 'dart:convert';

import 'package:eventi_in_zona/models/registered_user.dart';
import 'package:objectid/objectid.dart';

class AppUser extends RegisteredUser {
  late int nFollowers;
  late int nFollowings;
  late int nLikes;

  AppUser(data) : super(data) {
    nFollowers = data['nFollowers'] ?? 0;
    nLikes = data['nLikes'] ?? 0;
    nFollowings = data['nFollowings'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll({'nFollowers': nFollowers});
    result.addAll({'nFollowings': nFollowings});
    result.addAll({'nLikes': nLikes});
    return result;
  }
}
