class LatLonLocation {
  late String type;
  late double latitude;
  late double longitude;

  LatLonLocation(data) {
    type = data['type'];
    latitude = data['coordinates'][1];
    longitude = data['coordinates'][0];
  }
}
