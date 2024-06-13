import 'dart:convert';

import 'package:app/models/entities/order_entity.dart';
import 'package:app/models/providers/api_links.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiProvider {
  Future<http.Response> login(String login, String password) async{
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.loginUrl);
    final headers = {'Content-Type': 'application/json' };
    final body = jsonEncode({'login': login, 'password': password});
    return await http.post(url, headers: headers, body: body);
  }

  Future<http.Response> register(String login, String password, String firstName, String lastName, String phoneNumber) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.registerUrl);
    final headers = {'Content-Type': 'application/json' };
    final body = jsonEncode({ 'login': login, 'password': password, 'first_name': firstName, 'last_name': lastName, 'phone_number': phoneNumber });
    return await http.post(url, headers: headers, body: body);
  }

  Future<http.Response> getProfileByToken(String token) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.userDataUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.get(url, headers:  headers);
  }

  Future<http.Response> getAvailableTablesByDate(String token, DateTime date) async {
    final query = {
      'time': DateFormat('dd.MM.yyyy HH:mm').format(date)
    };
    final url = Uri.http(ApiLinks.baseUrlNoHttp, ApiLinks.tablesAvailableUrl, query);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.get(url, headers:  headers);
  }

  Future<http.Response> getBookingByUser(String token) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.bookingUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.get(url, headers:  headers);
  }

  Future<http.Response> bookTable(String token, DateTime date, int tableNum) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.bookTableUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    final body = jsonEncode({'date': DateFormat('dd.MM.yyyy HH:mm').format(date), 'table': tableNum});
    return await http.post(url, headers: headers, body: body);
  }

  Future<http.Response> cancelBooking(String token) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.cancelBookingUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.post(url, headers: headers);
  }

  Future<dynamic> getProductsList() async {
    // ждем список продуктов
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> proceedOrder(OrderEntity order) async {
    // отправляем заказ пользователя
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> updateOrderStatus(int orderId, String newStatus) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> getUserOrders() async {
    // ждем список заказов пользователя (и старых и активных)
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<http.Response> getPromoMaterials(String token) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.promoUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.get(url, headers:  headers);
  }

  Future<dynamic> getShiftData() async {
    await Future.delayed(const Duration(seconds: 2));
  }

}