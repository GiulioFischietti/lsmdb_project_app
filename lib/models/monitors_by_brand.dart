import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/models/monitor.dart';
import 'package:eventi_in_zona/models/product.dart';

class MonitorsByBrand {
  late List<Monitor> monitors = [];
  late String brand;

  MonitorsByBrand(data) {
    brand = data['brand'];

    for (var item in data['monitors']) {
      // print(item);
      monitors.add(Monitor(item));
    }
  }
}
