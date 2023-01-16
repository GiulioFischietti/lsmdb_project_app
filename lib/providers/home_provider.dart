import 'dart:core';

import 'package:eventi_in_zona/models/beer.dart';
import 'package:eventi_in_zona/models/beers_by_brand.dart';
import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/models/books_by_brand.dart';
import 'package:eventi_in_zona/models/entity_minimal.dart';
import 'package:eventi_in_zona/models/monitor.dart';
import 'package:eventi_in_zona/models/monitors_by_brand.dart';
import 'package:eventi_in_zona/models/product.dart';
import 'package:eventi_in_zona/repositories/product_repo.dart';
import 'package:eventi_in_zona/models/event_minimal.dart';
import 'package:flutter/material.dart';

import '../repositories/entity_repo.dart';
import '../repositories/event_repo.dart';
import '../repositories/location_repo.dart';

class HomeProvider extends ChangeNotifier {
  bool loading = false;
  List<Beer> beers = [];
  late Beer beer;
  late Book book;
  late Monitor monitor;

  List<Book> books = [];
  List<Monitor> monitors = [];
  List<Product> productsResult = [];

  List<BeersByBrand> beersByBrand = [];
  List<MonitorsByBrand> monitorsByBrand = [];
  List<BooksByBrand> booksByBrand = [];

  List<EventMinimal> nearEvents = [];
  List<EntityMinimal> nearClubs = [];

  void getNearEvents(BuildContext context) async {
    // loading = true;
    // notifyListeners();
    var position = await getStoredLocation(context);
    Map<String, dynamic> body = {
      "lat": double.parse(position['lat']),
      "lon": double.parse(position['lon']),
      "start": DateTime.now().toIso8601String(),
      "maxDistance": 100000
    };
    var json = await getNearEventsJson(body);
    nearEvents = (json['data'] as List).map((e) => EventMinimal(e)).toList();
    // loading = false;
    notifyListeners();
  }

  void getNearClubs(BuildContext context) async {
    // loading = true;
    // notifyListeners();
    var position = await getStoredLocation(context);
    Map<String, dynamic> body = {
      "lat": double.parse(position['lat']),
      "lon": double.parse(position['lon']),
      "start": DateTime.now().toIso8601String(),
      "maxDistance": 100000
    };
    var json = await getNearClubsJson(body);
    nearClubs = (json['data'] as List).map((e) => EntityMinimal(e)).toList();
    // loading = false;
    notifyListeners();
  }

  void getBeers() async {
    var json = await getBeersData();
    beers = (json['data'] as List).map((e) => Beer(e)).toList();
    notifyListeners();
  }

  void getBeerById(int id) async {
    loading = true;
    notifyListeners();
    var beerJson = await getBeerByIdData(id);
    beer = Beer(beerJson['data']);
    loading = false;
    notifyListeners();
  }

  void getBooks() async {
    var json = await getBooksData();
    books = (json['data'] as List).map((e) => Book(e)).toList();
    notifyListeners();
  }

  void getBookById(int id) async {
    loading = true;
    notifyListeners();
    var json = await getBookByIdData(id);
    book = Book(json['data']);
    loading = false;
    notifyListeners();
  }

  void getMonitors() async {
    var json = await getMonitorsData();
    monitors = (json['data'] as List).map((e) => Monitor(e)).toList();
    notifyListeners();
  }

  void getMonitorById(int id) async {
    loading = true;
    notifyListeners();
    var json = await getMonitorByIdData(id);
    monitor = Monitor(json['data']);
    loading = false;
    notifyListeners();
  }

  void getBooksByBrand() async {
    var json = await getBooksByBrandData();
    booksByBrand = (json['data'] as List).map((e) => BooksByBrand(e)).toList();
    notifyListeners();
  }

  void getBeersByBrand() async {
    var json = await getBeersByBrandData();
    beersByBrand = (json['data'] as List).map((e) => BeersByBrand(e)).toList();
    notifyListeners();
  }

  void getMonitorsByBrand() async {
    var json = await getMonitorsByBrandData();
    monitorsByBrand =
        (json['data'] as List).map((e) => MonitorsByBrand(e)).toList();
    notifyListeners();
  }

  void searchProducts(String keyword) async {
    var json = await searchProdutsData(keyword);
    productsResult = (json['data'] as List).map((e) => Product(e)).toList();
    notifyListeners();
  }
}
