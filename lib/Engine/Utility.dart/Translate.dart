// ignore_for_file: file_names

class Translator {
  ArtistText artist;
  EventText event;
  LoginText login;
  NeedfyText needfy;
  NotificationText notificationText;
  OrganizerText organizerText;
  PasswordText passwordText;
  ProfileText profileText;
  ReviewText reviewText;
  ShowcaseText showcaseText;
  AuthText authText;

  Translator(data) {
    this.artist = ArtistText(data['artist']);
    this.event = EventText(data['event']);
    this.login = LoginText(data['login']);
    this.needfy = NeedfyText(data['needfy']);
    this.notificationText = NotificationText(data['notifications']);
    this.authText = AuthText(data['auth']);
    this.organizerText = OrganizerText(data['organizer']);
    this.passwordText = PasswordText(data['passwords']);
    this.profileText = ProfileText(data['profile']);
    this.reviewText = ReviewText(data['review']);
    this.showcaseText = ShowcaseText(data['showcase']);
  }

  factory Translator.fromJson(Map<String, dynamic> parsedJson) {
    return Translator(parsedJson);
  }
}

class AuthText {
  String failed;
  String password;
  String throttle;
  String terms_text_1;
  String terms_text_2;
  String terms_text_3;
  String terms_text_4;
  String terms_text_5;
  String confirm_password;
  String offers;
  String offers_text_1;
  String offers_text_2;
  String customization;
  String customization_text_1;
  String customization_text_2;
  String login_app;
  String register;
  String login_text_1;
  String login_text_2;
  String login_text_3;
  String login_slogan;
  String login_fb;
  String password_match_error;

  AuthText(data) {
    this.failed = data['failed'];
    this.password = data['password'];
    this.throttle = data['throttle'];
    this.password_match_error = data['password_match_error'];
    this.terms_text_1 = data['terms_text_1'];
    this.terms_text_2 = data['terms_text_2'];
    this.terms_text_3 = data['terms_text_3'];
    this.terms_text_4 = data['terms_text_4'];
    this.terms_text_5 = data['terms_text_5'];
    this.confirm_password = data['confirm_password'];
    this.offers = data['offers'];
    this.offers_text_1 = data['offers_text_1'];
    this.offers_text_2 = data['offers_text_2'];
    this.customization = data['customization'];
    this.customization_text_1 = data['customization_text_1'];
    this.customization_text_2 = data['customization_text_2'];
    this.login_app = data['login_app'];
    this.login_text_1 = data['login_text_1'];
    this.login_text_2 = data['login_text_2'];
    this.login_text_3 = data['login_text_3'];
    this.register = data['register'];
    this.login_slogan = data['login_slogan'];
    this.login_fb = data['login_fb'];
  }
}

class LoginText {
  String register;
  String login;
  String have_account;
  String password_recovered;

  LoginText(data) {
    this.register = data['register'];
    this.login = data['login'];
    this.have_account = data['have_account'];
    this.password_recovered = data['password_recovered'];
  }
}

class ShowcaseText {
  String digital_event;
  String now;
  String today;
  String showmore;
  String empty_showcase;

  ShowcaseText(data) {
    this.digital_event = data['digital'];
    this.now = data['now'];
    this.today = data['today'];
    this.showmore = data['showmore'];
    this.empty_showcase = data['empty_showcase'];
  }
}

class ReviewText {
  String vote;
  String voted;
  String review;
  String modify_review;
  String new_review;
  String response;
  String modify;
  String delete;
  String post;
  String update;
  String show_response;

  String textarea_placeholder;

  ReviewText(data) {
    this.vote = data['vote'];
    this.voted = data['voted'];
    this.review = data['review'];
    this.new_review = data['new_review'];
    this.modify_review = data['modify_review'];
    this.textarea_placeholder = data['textarea_placeholder'];
    this.delete = data['delete'];
    this.response = data['response'];
    this.modify = data['modify'];
    this.post = data['post'];
    this.update = data['update'];
    this.show_response = data['show_response'];
  }
}

class ProfileText {
  String reviewed;
  String following;
  String saved;
  String notifications;
  String profile;
  String surname;
  String additional_information;
  String gender;
  String male;
  String female;
  String update;
  String image_text;
  String birthday;
  String biography;
  String phone;
  String success_edit;
  String password_old;
  String password_new;
  String password_confirm;
  String name;
  String settings;
  String modify_profile;
  String modify_password;
  String username_used;
  String additional_information_text;

  ProfileText(data) {
    this.notifications = data['notifications'];
    this.reviewed = data['reviewed'];
    this.phone = data['phone'];
    this.following = data['following'];
    this.saved = data['saved'];
    this.profile = data['profile'];
    this.surname = data['surname'];
    this.name = data['name'];
    this.additional_information = data['additional_information'];
    this.gender = data['gender'];
    this.male = data['male'];
    this.female = data['female'];
    this.update = data['update'];
    this.image_text = data['image_text'];
    this.birthday = data['birthday'];
    this.biography = data['biography'];
    this.success_edit = data['success_edit'];
    this.modify_profile = data['modify_profile'];
    this.username_used = data['username_used'];
    this.modify_password = data['modify_password'];
    this.password_old = data['password_old'];
    this.password_new = data['password_new'];
    this.password_confirm = data['password_confirm'];
    this.settings = data['settings'];
    this.additional_information_text = data['additional_information_text'];
  }
}

class PasswordText {
  String sent;
  String throttled;
  String reset;
  String token;
  String user;
  String forgot;

  PasswordText(data) {
    this.sent = data['sent'];
    this.throttled = data['throttled'];
    this.reset = data['reset'];
    this.token = data['token'];
    this.user = data['user'];
    this.forgot = data['forgot'];
  }
}

class OrganizerText {
  String follow;
  String unfollow;
  String follower;
  String follow_success;
  String unfollow_success;

  OrganizerText(data) {
    this.follow = data['follow'];
    this.unfollow = data['unfollow'];
    this.follower = data['follower'];
    this.follow_success = data['follow_success'];
    this.unfollow_success = data['unfollow_success'];
  }
}

class NotificationText {
  String alt_image_notification;
  String new_notification;
  String other;
  String all;
  String no_notifications;

  NotificationText(data) {
    this.alt_image_notification = data['alt_image_notification'];
    this.new_notification = data['new_notification'];
    this.other = data['other'];
    this.all = data['all'];
    this.no_notifications = data['no_notifications'];
  }
}

class NeedfyText {
  String organizer;
  String club;
  String artist;
  String skip;
  String search;

  NeedfyText(data) {
    this.organizer = data['organizer'];
    this.club = data['club'];
    this.artist = data['artist'];
    this.skip = data['skip'];
    this.search = data['search'];
  }
}

class EventText {
  String organizer_primary;
  String and;
  String others;
  String save;
  String from_hours;
  String to_hours;
  String from_day;
  String to_day;
  String remove;
  String show_more;
  String show_less;
  String digital_place_event;
  String organizer;
  String terminated;
  String now;
  String event_saved_success;
  String event_remove_success;
  String until;
  EventText(data) {
    this.organizer_primary = data['organizer_primary'];
    this.and = data['and'];
    this.others = data['organizers'];
    this.save = data['save'];
    this.from_hours = data['from_hours'];
    this.from_day = data['from_day'];
    this.to_day = data['to_day'];
    this.to_hours = data['to_hours'];
    this.remove = data['remove'];
    this.show_less = data['show_less'];
    this.show_more = data['show_more'];
    this.digital_place_event = data['digital_place_event'];
    this.organizer = data['organizer'];
    this.terminated = data['terminated'];
    this.now = data['now'];
    this.event_remove_success = data['event_remove_success'];
    this.event_saved_success = data['event_saved_success'];
    this.until = data['until'];
  }
}

class ArtistText {
  String dj;
  String producer;
  String band;
  String singer;
  String orchestra;
  String instrumentalist;

  ArtistText(data) {
    this.dj = data['dj'];
    this.producer = data['producer'];
    this.band = data['band'];
    this.singer = data['singer'];
    this.orchestra = data['orchestra'];
    this.instrumentalist = data['instrumentalist'];
  }
}
