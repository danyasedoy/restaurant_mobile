import 'dart:convert';

import 'package:app/models/entities/product_entity.dart';
import 'package:app/models/services/abstract_service.dart';
import 'package:intl/intl.dart';

import '../entities/order_entity.dart';

class OrdersListService extends AbstractService {
  Future<List<OrderEntity>> getOrders() async {
    final token = await storageProvider.loadToken();
    final response = await apiProvider.getUserOrders(token!);
    List<OrderEntity> orders = [];
    if (response.statusCode == 200) {
      for (var orderJson in jsonDecode(response.body)) {
        List<ProductEntity> products = [];
        for (var prodJson in orderJson['products']) {
          products.add(ProductEntity.fromJson(prodJson));
        }
        if (orderJson['address'] == null) {
          orders.add(OrderEntity.existingWithTable(
              orderJson['id'],
              DateFormat('dd.MM.yyyy HH:mm').parse(orderJson['date']),
              orderJson['table'],
              statusFromString(orderJson['status']),
              products
          ));
        }
        else {
          orders.add(OrderEntity.existingDelivery(
              orderJson['id'],
              DateFormat('dd.MM.yyyy HH:mm').parse(orderJson['date']),
              orderJson['address'],
              statusFromString(orderJson['status']),
              products
          ));
        }
      }
    }
    return orders;
  }
}