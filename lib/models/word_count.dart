class WordCount {
  late String word;
  late int count;

  WordCount(data) {
    word = data['_id'];
    count = data['count'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'word': word});
    result.addAll({'count': count});

    return result;
  }
}
