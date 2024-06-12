import 'package:app/models/entities/product_entity.dart';
import 'package:app/models/services/abstract_service.dart';

import '../entities/order_entity.dart';

class OrdersListService extends AbstractService {
  Future<List<OrderEntity>> getOrders() async {
    await apiProvider.getUserOrders();
    return [
      OrderEntity.existingWithTable(1, DateTime.now(), 5, OrderStatus.ready, [ProductEntity.withCount(1, 'Шаварма', 999, 2)]),
      OrderEntity.existingDelivery(2, DateTime.now(), "Moscow MOSCOW MOSCOW MOSCOW MOSCOW MOSCOW MOSKOW", OrderStatus.delivery_taken, [ProductEntity.withCount(1, 'Шаварма', 999, 1), ProductEntity.withCount(2, 'Шмара', 929, 6)])
    ];
  }
}