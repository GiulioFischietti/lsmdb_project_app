class LatLonLocation {
  late String type;
  late double latitude;
  late double longitude;

  LatLonLocation(data) {
    data = data ?? {};
    type = data['type'] ?? "";
    latitude = data['coordinates'] != null ? data['coordinates'][1] : 0;
    longitude = data['coordinates'] != null ? data['coordinates'][0] : 0;
  }
}
