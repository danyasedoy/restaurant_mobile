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
    await getOrder();
    notifyListeners();
    return await service.getProducts();
  }

  Future<void> saveOrder() async{
    if (state.order != null) await service.saveOrder(state.order!);
  }

  Future<void> getOrder() async{
    state.order = await service.getOrder();
  }

  addProductToOrder(ProductEntity product) {
    if (state.order == null) {
      state.order = OrderEntity(null, DateTime.now(), null, null);
      state.order!.products.add(product);
    }
    else {
      if (state.order!.products.contains(product)) {
        final index = state.order!.products.indexOf(product);
        state.order!.products[index].count += 1;
      }
      else {
        state.order!.products.add(product);
      }
    }
    state.message = "${product.name} добавлен в заказ";
    saveOrder();
    notifyListeners();
  }


}