import 'dart:convert';

class LatLonLocation {
  late String type;
  late double latitude;
  late double longitude;

  LatLonLocation(data) {
    data = data ?? {};
    type = data['type'] ?? "";
    latitude = data['coordinates'] != null
        ? double.parse(data['coordinates'][1].toString())
        : 0;
    longitude = data['coordinates'] != null
        ? double.parse(data['coordinates'][0].toString())
        : 0;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'type': type});
    result.addAll({
      'coordinates': [longitude, latitude]
    });

    return result;
  }
}
