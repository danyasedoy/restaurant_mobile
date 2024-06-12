import 'package:app/models/entities/order_entity.dart';
import 'package:app/models/entities/product_entity.dart';
import 'package:app/models/services/abstract_service.dart';

class OrderService extends AbstractService {
  Future<List<ProductEntity>> getProducts() async {
    await apiProvider.getProductsList();
    return [
      ProductEntity(1, 'Пицца-пицца, паста-паста, карборана-шмара', 120),
      ProductEntity(2, 'Шаварма', 100),
      ProductEntity(3, "Кетчунез", 50)
    ];
  }

  Future<void> saveOrder(OrderEntity order) async {
    await storageProvider.saveOrderToCache(order);
  }

  Future<OrderEntity?> getOrder() async {
    return await storageProvider.loadOrderFromCache();
  }

  Future<void> proceedOrder(OrderEntity order) async {
    await apiProvider.proceedOrder(order);
    await storageProvider.deleteOrderFromCache();
  }

  Future<dynamic> updateOrderStatus(OrderEntity order, OrderStatus newStatus) async{
    if (newStatus == OrderStatus.served) {
      await storageProvider.deleteOrderFromCache();
    }
    await apiProvider.updateOrderStatus(order.id!, newStatus.statusString);
  }
}