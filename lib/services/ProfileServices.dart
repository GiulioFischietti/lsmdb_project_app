// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'dart:convert';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Model/ShowcaseArtistsModel.dart';
import 'package:project_app/Model/ShowcaseClubsModel.dart';
import 'package:project_app/Model/ShowcaseEventsModel.dart';
import 'package:project_app/Model/ShowcaseOrganizersModel.dart';
import 'package:project_app/Model/ShowcaseReviewsModel.dart';
import 'package:project_app/Model/UserModel.dart';
import 'package:project_app/View/BottomTab/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ShowcaseClubModel> getFollowedClubs(String slug) async {
  final response = await Request.get('clubsfollowed/' + slug);
  // print(response);
  ShowcaseClubModel showcaseclubsfollowed;
  showcaseclubsfollowed = ShowcaseClubModel.fromJson(jsonDecode(response));
  return showcaseclubsfollowed;
}

Future<UserModel> getUser(String slug) async {
  String query = slug != null ? ("/" + slug) : "";
  String response = await Request.get('user' + query);

  UserModel user;
  user = UserModel.fromJson(jsonDecode(response));
  return user;
}

Future<ShowcaseOrganizersModel> getFollowedOrganizers(slug) async {
  final response = await Request.get('organizersfollowed/' + slug);

  ShowcaseOrganizersModel showcaseorganizersfollowed;
  showcaseorganizersfollowed =
      ShowcaseOrganizersModel.fromJson(jsonDecode(response));
  return showcaseorganizersfollowed;
}

Future<ShowcaseArtistsModel> getFollowedArtists(String slug) async {
  final response = await Request.get('artistsfollowed/' + slug);

  ShowcaseArtistsModel showcaseartistsfollowed;

  showcaseartistsfollowed = ShowcaseArtistsModel.fromJson(jsonDecode(response));
  return showcaseartistsfollowed;
}

Future<ShowcaseEventsModel> getSavedEvents(String slug) async {
  prefs = await SharedPreferences.getInstance();

  String text = prefs.getString('languagepack');
  final response = await Request.get('savedevents/' + slug);

  ShowcaseEventsModel showcaseeventssaved;

  showcaseeventssaved = ShowcaseEventsModel.fromJson(jsonDecode(response));
  return showcaseeventssaved;
}

Future<ShowcaseReviewsModel> getReviews(String slug) async {
  final response = await Request.get('profilereviews/' + slug);

  ShowcaseReviewsModel showcasereviews;
  showcasereviews = ShowcaseReviewsModel.fromJson(jsonDecode(response));
  return showcasereviews;
}
