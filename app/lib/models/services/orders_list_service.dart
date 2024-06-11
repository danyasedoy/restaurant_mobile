import 'package:app/models/services/abstract_service.dart';

import '../entities/order_entity.dart';

class OrdersListService extends AbstractService {
  Future<List<OrderEntity>> getOrders() async {
    await apiProvider.getUserOrders();
    return [
      OrderEntity.existingWithTable(1, DateTime.now(), 5, OrderStatus.confirmed),
      OrderEntity.existingDelivery(2, DateTime.now(), "Moscow MOSCOW MOSCOW MOSCOW MOSCOW MOSCOW MOSKOW", OrderStatus.delivered)
    ];
  }
}