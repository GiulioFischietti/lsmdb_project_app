import 'dart:convert';

class YearRate {
  late int year;
  late int count;
  late double avg;

  YearRate(data) {
    year = data["_id"]['year'];
    count = data['count'];
    avg = double.parse(data['avg'].toString());
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'year': year});
    result.addAll({'rate': avg});

    return result;
  }
}
