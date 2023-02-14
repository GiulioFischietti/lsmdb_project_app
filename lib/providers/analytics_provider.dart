import 'package:eventi_in_zona/models/club_genres_stats.dart';
import 'package:eventi_in_zona/models/critic_user.dart';
import 'package:eventi_in_zona/models/word_count.dart';
import 'package:eventi_in_zona/models/yearRate.dart';
import 'package:eventi_in_zona/repositories/analytics_repo.dart'
    as analyticsRepo;
import 'package:flutter/cupertino.dart';
import 'package:objectid/objectid.dart';

class AnalyticsProvider extends ChangeNotifier {
  List<YearRate> yearRates = [];
  List<WordCount> wordCounts = [];
  List<CriticUser> criticUsers = [];
  List<ClubGenresStats> clubStats = [];
  bool loading = true;
  bool loadingClubStatsPagination = false;

  void getClubsStats() async {
    loading = true;
    notifyListeners();

    var jsonData = await analyticsRepo.getClubsStats();

    clubStats = (jsonData['data'] as List)
        .map((item) => ClubGenresStats(item))
        .toList();

    loading = false;
    notifyListeners();
  }

  void getCriticScore(DateTime fromDate) async {
    loading = true;
    notifyListeners();

    var jsonData = await analyticsRepo.getCriticScore(fromDate);

    criticUsers =
        (jsonData['data'] as List).map((item) => CriticUser(item)).toList();

    loading = false;
    notifyListeners();
  }

  void getEntityRateByYear(ObjectId entityId) async {
    loading = true;
    notifyListeners();

    var jsonData = await analyticsRepo.getEntityRateByYear(entityId);

    yearRates =
        (jsonData['data'] as List).map((item) => YearRate(item)).toList();

    loading = false;
    notifyListeners();
  }

  void getMostUsedWords(ObjectId entityId) async {
    loading = true;
    notifyListeners();

    var jsonData = await analyticsRepo.getMostUsedWords(entityId);

    wordCounts =
        (jsonData['data'] as List).map((item) => WordCount(item)).toList();

    loading = false;
    notifyListeners();
  }
}
