import 'dart:convert';

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
        if (orderJson['address'] == null) {
          orders.add(OrderEntity.existingWithTable(
              orderJson['id'],
              DateFormat('dd.MM.yyyy HH:mm').parse(orderJson['date']),
              orderJson['table'],
              statusFromString(orderJson['status']),
              // TODO добавить продукты
              []
          ));
        }
        else {
          orders.add(OrderEntity.existingDelivery(
              orderJson['id'],
              DateFormat('dd.MM.yyyy HH:mm').parse(orderJson['date']),
              orderJson['address'],
              statusFromString(orderJson['status']),
              []
          ));
        }
      }
    }
    return orders;
  }
}