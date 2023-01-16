import 'package:eventi_in_zona/repositories/repo.dart';

Future<dynamic> getProductAnalyticsData(
    DateTime startDate, DateTime endDate, String sorting) async {
  return await Repo().getData(
      "analytics/productanalytics?start_date=${startDate.toLocal().toString().split(' ')[0]}&end_date=${endDate.toLocal().toString().split(' ')[0]}&sorting=$sorting");
}

Future<dynamic> getCustomerAnalyticsData(
    DateTime startDate, DateTime endDate, String sorting) async {
  return await Repo().getData(
      "analytics/customeranalytics?start_date=${startDate.toLocal().toString().split(' ')[0]}&end_date=${endDate.toLocal().toString().split(' ')[0]}&sorting=$sorting");
}

Future<dynamic> getExpencesAnalyticsData(
    DateTime startDate, DateTime endDate, String sorting) async {
  return await Repo().getData(
      "analytics/expencesanalytics?start_date=${startDate.toLocal().toString().split(' ')[0]}&end_date=${endDate.toLocal().toString().split(' ')[0]}&sorting=$sorting");
}
