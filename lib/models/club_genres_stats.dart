import 'dart:convert';
import 'package:eventi_in_zona/models/entity_minimal.dart';
import 'package:objectid/objectid.dart';

class ClubGenresStats {
  late EntityMinimal club;
  List<String> genres = [];
  late int nGenres;
  late int eventsOrganized;

  ClubGenresStats(data) {
    club = EntityMinimal(data['_id']['club']);
    genres = (data['genres'] as List)
        .map((item) => data['genres'].toString())
        .toList();
    nGenres = data['nGenres'];
    eventsOrganized = data['eventsOrganized'];
  }
}
