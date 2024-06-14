import 'package:app/models/entities/order_entity.dart';
import 'package:app/models/services/orders_list_service.dart';
import 'package:app/viewmodels/abstract_viewmodel.dart';
import 'package:flutter/material.dart';


class OrdersListViewModel extends AbstractViewModel with ChangeNotifier {
  @override
  final OrdersListService service = OrdersListService();
  bool? isClient;
  int? roleId;
  var refreshFlag = false;

  Future<List<OrderEntity>> fetchOrders() async {
    roleId == null ? roleId = await service.getRoleId() : {};
    isClient == null ? isClient = roleId == 1 : {};
    return await service.getOrders();
  }

  refreshScreen() {
    refreshFlag = !refreshFlag;
    notifyListeners();
  }

}