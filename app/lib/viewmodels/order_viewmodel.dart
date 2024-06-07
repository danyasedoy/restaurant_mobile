import 'package:app/models/entities/order_entity.dart';
import 'package:app/models/entities/product_entity.dart';
import 'package:app/models/services/order_service.dart';
import 'package:app/viewmodels/abstract_viewmodel.dart';
import 'package:flutter/material.dart';

class OrderScreenState {
  OrderEntity? order;
  String message = "";
}

class OrderViewModel extends AbstractViewModel with ChangeNotifier {
  final state = OrderScreenState();
  @override
  final OrderService service = OrderService();

  Future<List<ProductEntity>> fetchProducts() async {
    await loadOrder();
    return await service.getProducts();
  }

  Future<void> saveOrder({OrderEntity? order}) async{
    if (order!= null) {
      await service.saveOrder(order);
      return;
    }
    if (state.order != null) await service.saveOrder(state.order!);
  }

  Future<void> loadOrder() async{
    state.order = await service.getOrder();
    notifyListeners();
  }

  addProductToOrder(ProductEntity product) {
    product.count = 1;
    if (state.order == null) {
      state.order = OrderEntity(null, DateTime.now(), null, null);
      state.order!.products.add(product);
    }
    else {
      if (state.order!.products.any((prod) => prod.id == product.id)) {
        state.message = "${product.name} уже добавлен в заказ";
        notifyListeners();
        return;
      }
      else {
        state.order!.products.add(product);
      }
    }
    state.message = "${product.name} добавлен в заказ";
    saveOrder();
    notifyListeners();
  }

  Future<void> confirmOrder(OrderEntity order) async{
    // TODO
  }

}