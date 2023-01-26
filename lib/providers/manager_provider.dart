import 'package:eventi_in_zona/models/beer.dart';
import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/models/customer.dart';
import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/models/manager.dart';
import 'package:eventi_in_zona/models/monitor.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/models/product.dart';
import 'package:eventi_in_zona/models/product_order.dart';
import 'package:eventi_in_zona/models/products_by_category.dart';
import 'package:eventi_in_zona/repositories/auth_repo.dart';
import 'package:eventi_in_zona/repositories/order_repo.dart';
import 'package:eventi_in_zona/repositories/event_repo.dart' as eventRepo;
import 'package:eventi_in_zona/repositories/product_repo.dart';
import 'package:eventi_in_zona/repositories/analytics_repo.dart';

import 'package:flutter/material.dart';

class ManagerProvider extends ChangeNotifier {
  bool loading = false;

  List<ProductsByCategory> productsByCategory = [];
  List<ProductOrder> productOrders = [];
  List<Order> orders = [];

  List<Product> beerAnalytics = [];
  List<Product> bookAnalytics = [];
  List<Product> monitorAnalytics = [];

  List<Customer> customerAnalytics = [];
  int totalOrders = 0;
  double totalSpent = 0.0;

  int totalBeers = 0;
  int totalBooks = 0;
  int totalMonitors = 0;

  late Book book;
  late Monitor monitor;
  late Beer beer;
  late Manager manager;

  void getProductsByCategory() async {
    var json = await getProductsByCategoryData();
    productsByCategory =
        (json['data'] as List).map((e) => ProductsByCategory(e)).toList();
    notifyListeners();
  }

  Future<void> getOrderDetails(int order_id, int user_id) async {
    var json = await getUserOrderDetailsData(order_id, user_id);
    productOrders = (json['data'] as List).map((e) => ProductOrder(e)).toList();
    notifyListeners();
  }

  void getBeerById(int id) async {
    loading = true;
    notifyListeners();
    var json = await getBeerByIdData(id);
    beer = Beer(json['data']);
    loading = false;
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

  void getBookById(int id) async {
    loading = true;
    notifyListeners();
    var json = await getBookByIdData(id);
    book = Book(json['data']);
    loading = false;
    notifyListeners();
  }

  Future<bool> logInAsManager(String username, String password) async {
    var data = await logInAsManagerData(username, password);
    manager = Manager(data['data']);
    notifyListeners();
    return data['success'];
  }

  void updateMonitor(Monitor updatedMonitor) async {
    loading = true;
    notifyListeners();
    var json = await updateMonitorData(updatedMonitor);
    getMonitorById(updatedMonitor.productId);
    getProductsByCategory();
    loading = false;
    notifyListeners();
  }

  void updateBeer(Beer updatedBeer) async {
    loading = true;
    notifyListeners();
    var json = await updateBeerData(updatedBeer);
    getBeerById(updatedBeer.productId);
    getProductsByCategory();
    loading = false;
    notifyListeners();
  }

  void createBeer(Beer updatedBeer) async {
    loading = true;
    notifyListeners();
    var json = await createBeerData(updatedBeer);

    getProductsByCategory();
    loading = false;
    notifyListeners();
  }

  void createBook(Book updatedBook) async {
    loading = true;
    notifyListeners();
    var json = await createBookData(updatedBook);

    getProductsByCategory();
    loading = false;
    notifyListeners();
  }

  void createMonitor(Monitor updatedMonitor) async {
    loading = true;
    notifyListeners();
    var json = await createMonitorData(updatedMonitor);

    getProductsByCategory();
    loading = false;
    notifyListeners();
  }

  void updateBook(Book updatedBook) async {
    loading = true;
    notifyListeners();
    var json = await updateBookData(updatedBook);
    getBookById(updatedBook.productId);
    getProductsByCategory();
    loading = false;
    notifyListeners();
  }

  void getManagedOrders() async {
    var json = await getManagerOrdersData();
    orders = (json['data'] as List).map((e) => Order(e)).toList();
    notifyListeners();
  }

  void getProductAnalytics(
      {required DateTime startDate,
      required DateTime endDate,
      String sorting = "desc"}) async {
    List<Product> _beerAnalytics = [];
    List<Product> _bookAnalytics = [];
    List<Product> _monitorAnalytics = [];
    int _totalBeers = 0;
    int _totalBooks = 0;
    int _totalMonitors = 0;
    var json = await getProductAnalyticsData(startDate, endDate, sorting);

    for (var product in json['data']['beers']) {
      _beerAnalytics.add(Product(product));
      _totalBeers += (product['product_count'] as int);
    }
    for (var product in json['data']['books']) {
      _bookAnalytics.add(Product(product));
      _totalBooks += (product['product_count'] as int);
    }
    for (var product in json['data']['monitors']) {
      _totalMonitors += (product['product_count'] as int);
      _monitorAnalytics.add(Product(product));
    }

    beerAnalytics = _beerAnalytics;
    bookAnalytics = _bookAnalytics;
    monitorAnalytics = _monitorAnalytics;

    totalBeers = _totalBeers;
    totalBooks = _totalBooks;
    totalMonitors = _totalMonitors;

    notifyListeners();
  }

  void getCustomerAnalytics(
      {required DateTime startDate,
      required DateTime endDate,
      String sorting = "desc"}) async {
    List<Customer> _customerAnalytics = [];
    int _totalOrders = 0;

    var json = await getCustomerAnalyticsData(startDate, endDate, sorting);

    for (var item in json['data']['users']) {
      _customerAnalytics.add(Customer(item));
      _totalOrders += (item['order_count'] as int);
    }

    totalOrders = _totalOrders;
    customerAnalytics = _customerAnalytics;

    notifyListeners();
  }

  void getExpencesAnalytics(
      {required DateTime startDate,
      required DateTime endDate,
      String sorting = "desc"}) async {
    List<Customer> _customerAnalytics = [];
    double _totalSpent = 0;

    var json = await getExpencesAnalyticsData(startDate, endDate, sorting);

    for (var item in json['data']['users']) {
      _customerAnalytics.add(Customer(item));
      _totalSpent += item['order_total'];
    }

    totalSpent = _totalSpent;
    customerAnalytics = _customerAnalytics;

    notifyListeners();
  }

  void updateStatusOrder(String status, int id) async {
    orders.where((element) => element.id == id).first.status = status;
    notifyListeners();
    var json = await updateStatusOrderData(status, id);
  }
}
