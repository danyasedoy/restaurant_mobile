import 'package:app/models/entities/order_entity.dart';
import 'package:app/models/services/orders_list_service.dart';
import 'package:app/viewmodels/abstract_viewmodel.dart';
import 'package:flutter/material.dart';


class OrdersListViewModel extends AbstractViewModel with ChangeNotifier {
  @override
  final OrdersListService service = OrdersListService();
  late final bool isClient;

  Future<List<OrderEntity>> fetchOrders() async {
    isClient = await service.getRoleId() == 0;
    return await service.getOrders();
  }

}