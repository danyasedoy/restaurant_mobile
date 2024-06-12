import 'dart:convert';

import 'package:app/models/entities/order_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider {
  Future<void> saveOrderToCache(OrderEntity order) async {
    final prefs = await SharedPreferences.getInstance();
    final orderJson = jsonEncode(order.toJson());
    await prefs.setString('order', orderJson);
  }

  Future<OrderEntity?> loadOrderFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final orderJson = prefs.getString('order');
      if (orderJson != null) {
        return OrderEntity.fromJson(jsonDecode(orderJson));
      }
      return null;
    }
    on Exception {
      return null;
    }
  }

  Future<void> deleteOrderFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('order');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> loadToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> saveUserRoleId(int roleId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('role', roleId);
  }

  Future<int?> loadUserRoleId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role');
  }
}