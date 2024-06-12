import 'package:app/models/entities/product_entity.dart';

class OrderEntity {
  final int? id;
  final DateTime dateTime;
  String? address;
  int? tableNum;
  OrderStatus status = OrderStatus.initial;
  List<ProductEntity> products = [];

  OrderEntity(this.id, this.dateTime, this.address, this.tableNum);

  factory OrderEntity.existingWithTable(int id, DateTime dateTime, int tableNum, OrderStatus status, List<ProductEntity> products) {
    var order =  OrderEntity(id, dateTime, null, tableNum);
    order.status = status;
    order.products = products;
    return order;
  }

  factory OrderEntity.existingDelivery(int id, DateTime dateTime, String address, OrderStatus status, List<ProductEntity> products) {
    var order =  OrderEntity(id, dateTime, address, null);
    order.status = status;
    order.products = products;
    return order;
  }

  OrderEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dateTime = DateTime.parse(json['dateTime']),
        address = json['address'],
        tableNum = json['tableNum'],
        status = OrderStatus.values.firstWhere(
                (e) => e.toString() == 'OrderStatus.${json['status'] as String}'),
        products = (json['products'] as List<dynamic>)
            .map((e) => ProductEntity.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
    'id': id,
    'dateTime': dateTime.toIso8601String(),
    'address': address,
    'tableNum': tableNum,
    'status': status.toString().split('.').last,
    'products': products.map((e) => e.toJson()).toList(),
  };

  // factory конструкторы для отдельных случаев

}

enum OrderStatus {
  initial,
  confirmed,
  cooking,
  ready,
  delivery_taken,
  delivery_served,
  served,
  cancelled
}

extension OrderStatusExtension on OrderStatus {
  String get statusString {
    switch (this) {
      case OrderStatus.initial:
        return 'Ожидание подтверждения';
      case OrderStatus.confirmed:
        return 'Принят';
      case OrderStatus.served:
        return 'Обслужен';
      case OrderStatus.cooking:
        return 'Готовится';
      case OrderStatus.ready:
        return 'Готов';
      case OrderStatus.delivery_taken:
        return 'Передан на доставку';
      case OrderStatus.delivery_served:
        return 'Доставлен';
      case OrderStatus.cancelled:
        return 'Отменён';
      default:
        return ''; // Или бросить исключение, если это не ожидаемое поведение
    }
  }
}