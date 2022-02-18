// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'NotificationVModel.dart';

class ShowcaseNotificationsModel {
  String _title_new;
  List<NotificationVModel> _new_notifications = [];
  String _title_old;
  List<NotificationVModel> _old_notifications = [];

  List<NotificationVModel> get new_notifications {
    return _new_notifications;
  }

  List<NotificationVModel> get old_notifications {
    return _old_notifications;
  }

  String get title_new {
    return this._title_new;
  }

  String get title_old {
    return this._title_old;
  }

  ShowcaseNotificationsModel(data) {
    if (data != null) {
      if (data['data']['new']['items'] != null) {
        for (var item in data['data']['new']['items']) {
          this.new_notifications.add(new NotificationVModel(item));
        }
      }
      if (data['data']['other']['items'] != null) {
        for (var item in data['data']['other']['items']) {
          this.old_notifications.add(new NotificationVModel(item));
        }
      }

      this._title_new = data['data']['new']['title'];
      this._title_old = data['data']['other']['title'];
    }
  }

  factory ShowcaseNotificationsModel.fromJson(Map<String, dynamic> parsedJson) {
    return ShowcaseNotificationsModel(parsedJson);
  }
}
