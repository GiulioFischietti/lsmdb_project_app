import 'dart:convert';

class Prediction {
  String description = "";
  String placeId = "";
  Prediction({
    required this.description,
    required this.placeId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'description': description});

    return result;
  }

  factory Prediction.fromMap(Map<String, dynamic> map) {
    return Prediction(
      description: map['description'] ?? '',
      placeId: map['place_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Prediction.fromJson(data) => Prediction.fromMap(data);
}
