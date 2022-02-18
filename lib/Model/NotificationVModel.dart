// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
class NotificationVModel {
  int id;
  String name_sender;
  String image_sender;
  String text_notification;
  String image_notification;
  int seen;
  String type_entity;
  int entity_id;

  NotificationVModel(data) {
    if (data != null) {
      this.id = data['id'];
      this.name_sender = data['name_sender'];
      this.image_sender = data['image_sender'];
      this.text_notification = data['text_notification'];
      this.image_notification = data['image_notification'];
      this.seen = data['seen'];
      this.entity_id = data['entity_id'];
      this.type_entity = data['type_entity'];
    }
  }

  factory NotificationVModel.fromJson(Map<String, dynamic> parsedJson) {
    return NotificationVModel(parsedJson);
  }
}
