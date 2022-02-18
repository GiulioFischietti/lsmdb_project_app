// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
class UploadImageResponse {
  String image;
  bool error;
  String message;

  UploadImageResponse(data) {
    this.image = data['image'];
    this.error = data['error'];
    this.message = data['message'];
  }

  factory UploadImageResponse.fromJson(Map<String, dynamic> parsedJson) {
    return UploadImageResponse(parsedJson);
  }
}
