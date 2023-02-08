import 'dart:math';

import 'package:eventi_in_zona/models/artist.dart';
import 'package:eventi_in_zona/models/club.dart';
import 'package:eventi_in_zona/models/organizer.dart';
import 'package:eventi_in_zona/models/review.dart';
import 'package:eventi_in_zona/repositories/entity_repo.dart';
import 'package:eventi_in_zona/repositories/review_repo.dart' as reviewRepo;
import 'package:flutter/cupertino.dart';
import 'package:objectid/objectid.dart';

class EntityProvider extends ChangeNotifier {
  late Club club;
  late Artist artist;
  late Organizer organizer;
  bool loading = false;
  bool loadingReviews = false;

  void unfollowArtist(ObjectId userId) {
    artist.followedByUser = false;
    notifyListeners();
    unfollowEntity(artist.id, userId);
  }

  void followArtist(ObjectId userId) {
    artist.followedByUser = true;
    notifyListeners();
    followEntity(artist.id, userId);
  }

  void unfollowClub(ObjectId userId) {
    club.followedByUser = false;
    notifyListeners();
    unfollowEntity(club.id, userId);
  }

  void followClub(ObjectId userId) {
    club.followedByUser = true;
    notifyListeners();
    followEntity(club.id, userId);
  }

  void unfollowOrganizer(ObjectId userId) {
    organizer.followedByUser = false;
    notifyListeners();
    unfollowEntity(organizer.id, userId);
  }

  void followOrganizer(ObjectId userId) {
    organizer.followedByUser = true;
    notifyListeners();
    followEntity(organizer.id, userId);
  }

  void getMoreReviewsOrganizer() async {
    loadingReviews = true;
    notifyListeners();
    int nSkip = organizer.reviews.length;
    int last = min(organizer.reviewIds.length, organizer.reviewIds.length + 10);
    List<ObjectId> reviewIds = organizer.reviewIds.sublist(nSkip, last);
    var json = await reviewRepo.getReviewByIds(reviewIds);
    List<Review> moreReviews =
        (json['data'] as List).map((e) => Review(e)).toList();
    organizer.reviews.addAll(moreReviews);
    loadingReviews = false;
    notifyListeners();
  }

  void getMoreReviewsClub() async {
    loadingReviews = true;
    notifyListeners();
    int nSkip = club.reviews.length;
    int last = min(club.reviewIds.length, club.reviews.length + 10);
    List<ObjectId> reviewIds = club.reviewIds.sublist(nSkip, last);
    var json = await reviewRepo.getReviewByIds(reviewIds);
    List<Review> moreReviews =
        (json['data'] as List).map((e) => Review(e)).toList();
    club.reviews.addAll(moreReviews);
    loadingReviews = false;
    notifyListeners();
  }

  void getMoreReviewsArtist() async {
    loadingReviews = true;
    notifyListeners();
    int nSkip = artist.reviews.length;
    int last = min(artist.reviewIds.length, artist.reviews.length + 10);
    List<ObjectId> reviewIds = artist.reviewIds.sublist(nSkip, last);
    var json = await reviewRepo.getReviewByIds(reviewIds);
    List<Review> moreReviews =
        (json['data'] as List).map((e) => Review(e)).toList();
    artist.reviews.addAll(moreReviews);
    loadingReviews = false;
    notifyListeners();
  }

  void addReviewOrganizer(Review review) async {
    organizer.reviews.insert(0, review);
    organizer.reviewedByUser = true;
    organizer.reviewIds.insert(0, review.id);
    var jsonResponse = await reviewRepo.addReview(review);
    organizer.reviews[0].id =
        ObjectId.fromHexString(jsonResponse['data']['reviewId']);
    organizer.avgRate =
        double.parse(jsonResponse['data']['avg'].toStringAsFixed(2));
    notifyListeners();
  }

  void editReviewOrganizer(Review review) async {
    int indexToEdit =
        organizer.reviews.indexWhere((element) => element.id == review.id);
    organizer.reviews[indexToEdit].description = review.description;
    organizer.reviews[indexToEdit].rate = review.rate;
    var jsonResponse = await reviewRepo.editReview(review);
    organizer.avgRate =
        double.parse(jsonResponse['data']['avg'].toStringAsFixed(2));
    notifyListeners();
  }

  void deleteReviewOrganizer(
      ObjectId entityId, ObjectId reviewId, ObjectId userId) async {
    organizer.reviewedByUser = false;
    organizer.reviews.removeWhere((element) => element.id == reviewId);
    organizer.nReviews--;
    organizer.reviewIds.remove(reviewId);

    var jsonResponse =
        await reviewRepo.deleteReviewEntity(entityId, reviewId, userId);
    organizer.avgRate =
        double.parse(jsonResponse['data']['avg'].toStringAsFixed(2));
    notifyListeners();
  }

  void addReviewClub(Review review) async {
    club.reviews.insert(0, review);
    club.reviewedByUser = true;
    club.reviewIds.insert(0, review.id);
    var jsonResponse = await reviewRepo.addReview(review);
    print(jsonResponse);
    club.reviews[0].id =
        ObjectId.fromHexString(jsonResponse['data']['reviewId']);
    club.avgRate = double.parse(jsonResponse['data']['avg'].toStringAsFixed(2));
    notifyListeners();
  }

  void editReviewClub(Review review) async {
    int indexToEdit =
        club.reviews.indexWhere((element) => element.id == review.id);
    club.reviews[indexToEdit].description = review.description;
    club.reviews[indexToEdit].rate = review.rate;
    var jsonResponse = await reviewRepo.editReview(review);
    club.avgRate = double.parse(jsonResponse['data']['avg'].toStringAsFixed(2));
    notifyListeners();
  }

  void deleteReviewClub(
      ObjectId entityId, ObjectId reviewId, ObjectId userId) async {
    club.reviewedByUser = false;
    club.reviews.removeWhere((element) => element.id == reviewId);
    club.reviewIds.remove(reviewId);
    club.nReviews--;
    var jsonResponse =
        await reviewRepo.deleteReviewEntity(entityId, reviewId, userId);
    club.avgRate = double.parse(jsonResponse['data']['avg'].toStringAsFixed(2));
    notifyListeners();
  }

  void addReviewArtist(Review review) async {
    artist.reviews.insert(0, review);
    artist.reviewedByUser = true;
    artist.reviewIds.insert(0, review.id);
    var jsonResponse = await reviewRepo.addReview(review);
    artist.reviews[0].id =
        ObjectId.fromHexString(jsonResponse['data']['reviewId']);
    artist.avgRate =
        double.parse(jsonResponse['data']['avg'].toStringAsFixed(2));
    notifyListeners();
  }

  void editReviewArtist(Review review) async {
    int indexToEdit =
        artist.reviews.indexWhere((element) => element.id == review.id);
    artist.reviews[indexToEdit].description = review.description;
    artist.reviews[indexToEdit].rate = review.rate;
    artist.nReviews--;
    var jsonResponse = await reviewRepo.editReview(review);
    artist.avgRate =
        double.parse(jsonResponse['data']['avg'].toStringAsFixed(2));
    notifyListeners();
  }

  void deleteReviewArtist(
      ObjectId entityId, ObjectId reviewId, ObjectId userId) async {
    artist.reviewedByUser = false;
    artist.reviews.removeWhere((element) => element.id == reviewId);
    artist.reviewIds.remove(reviewId);

    var jsonResponse =
        await reviewRepo.deleteReviewEntity(entityId, reviewId, userId);
    artist.avgRate =
        double.parse(jsonResponse['data']['avg'].toStringAsFixed(2));
    notifyListeners();
  }

  void getEntityById(String id, String userId) async {
    loading = true;
    notifyListeners();
    var json = await getEntityByIdJson(id, userId);
    switch (json['data']['type']) {
      case "club":
        club = Club(json['data']);
        break;
      case "artist":
        artist = Artist(json['data']);
        break;
      case "organizer":
        organizer = Organizer(json['data']);
        break;
      default:
        organizer = Organizer(json['data']);
    }

    loading = false;
    notifyListeners();
  }
}
