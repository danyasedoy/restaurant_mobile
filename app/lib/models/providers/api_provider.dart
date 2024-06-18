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

  Future<http.Response> getProductsList(String token) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.productsUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.get(url, headers:  headers);
  }

  Future<http.Response> proceedOrder(String token, OrderEntity order) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.createOrder);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    late final Object body;
    if (order.address != null) {
      body = jsonEncode({
        'address': order.address!,
        'products': order.products.map((p) => {'id': p.id, 'count': p.count}).toList()
      });
    }
    else {
      body = jsonEncode({
        'table': order.tableNum!,
        'products': order.products.map((p) => {'id': p.id, 'count': p.count}).toList()
      });
    }
    return await http.post(url, headers: headers, body: body);
  }

  Future<http.Response> getUserOrders(String token) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.ordersListUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.get(url, headers:  headers);
  }

  Future<http.Response> updateOrderStatus(String token, int orderId, String newStatus) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.changeOrderStatusUrl.replaceFirst('<id>', orderId.toString()));
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    final body = newStatus;
    return await http.post(url, headers: headers, body: body);
  }

  Future<http.Response> getPromoMaterials(String token) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.promoUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.get(url, headers:  headers);
  }

  Future<http.Response> getShiftData(String token) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.shiftUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.get(url, headers:  headers);
  }

  Future<http.Response> getReportData(String token) async {
    final url = Uri.parse(ApiLinks.baseUrl + ApiLinks.reportDataUrl);
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await http.get(url, headers:  headers);
  }

}