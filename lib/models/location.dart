import 'dart:convert';

class MyLocation {
  String? city;
  String? cap;
  double? latitude;
  double? longitude;
  MyLocation({
    this.city,
    this.latitude,
    this.longitude,
    this.cap,
  });

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'cap': cap,
    };
  }

  factory MyLocation.fromMap(Map<String, dynamic> map) {
    return MyLocation(
      city: map['administrative_area'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      cap: map['region_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyLocation.fromJson(String source) =>
      MyLocation.fromMap(json.decode(source)['data'][0]);
}
