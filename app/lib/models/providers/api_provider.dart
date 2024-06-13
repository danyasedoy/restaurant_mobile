import 'dart:convert';

import 'package:app/models/entities/order_entity.dart';
import 'package:app/models/providers/api_links.dart';
import 'package:http/http.dart' as http;

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

  Future<http.Response> getRoleByToken(String token) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.userDataUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.get(url, headers:  headers);
  }

  Future<dynamic> getAvailableTablesByDate(DateTime date) async {
    // ждем список свободных столиков
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> getBookingByUser() async {
    // ждем букинг или его отсутствие
    // букинг: номер столика и дата
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> bookTable(DateTime date, int tableNum) async {
    // ждем ответ - забучили или нет
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> cancelBooking() async {
    // ждем ответ - закенселили или нет
    // если что то у одного юзера максимум один букинг
    await Future.delayed(const Duration(seconds: 2));
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

  Future<dynamic> getPromoMaterials() async {
    // ждем список вот этих промоновостей ну вы поняли
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> getShiftData() async {
    await Future.delayed(const Duration(seconds: 2));
  }

}