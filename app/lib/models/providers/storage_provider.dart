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
    final prefs = await SharedPreferences.getInstance();
    final orderJson = prefs.getString('order');
    if (orderJson != null) {
      return OrderEntity.fromJson(jsonDecode(orderJson));
    }
    return null;
  }
}