import 'dart:convert';

import 'package:app/models/entities/order_entity.dart';
import 'package:app/models/entities/product_entity.dart';
import 'package:app/models/services/abstract_service.dart';

class OrderService extends AbstractService {
  Future<List<ProductEntity>> getProducts() async {
    final token = await storageProvider.loadToken();
    final response = await apiProvider.getProductsList(token!);
    final List<ProductEntity> products = [];
    if (response.statusCode == 200) {
      for (var productJson in jsonDecode(response.body)) {
        products.add(ProductEntity(productJson['id'], productJson['name'], productJson['price']));
      }
      return products;
    }
    else {
      // TODO обработать ошибку
      return products;
    }
  }

  Future<void> saveOrder(OrderEntity order) async {
    await storageProvider.saveOrderToCache(order);
  }

  Future<OrderEntity?> getOrder() async {
    return await storageProvider.loadOrderFromCache();
  }

  Future<bool> proceedOrder(OrderEntity order) async {
    final token = await storageProvider.loadToken();
    var response = await apiProvider.proceedOrder(token!, order);
    if (response.statusCode == 200) {
      await storageProvider.deleteOrderFromCache();
      return true;
    }
    return false;
  }

  Future<dynamic> updateOrderStatus(OrderEntity order, OrderStatus newStatus) async{
    // if (newStatus == OrderStatus.served) {
    //   await storageProvider.deleteOrderFromCache();
    // }
    final token = await storageProvider.loadToken();
    final response = await apiProvider.updateOrderStatus(token!, order.id!, newStatus.statusString);
  }
}