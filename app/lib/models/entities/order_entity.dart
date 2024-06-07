import 'package:app/models/entities/product_entity.dart';

class OrderEntity {
  final int? id;
  final DateTime dateTime;
  final String? address;
  final int? tableNum;
  OrderStatus status = OrderStatus.initial;
  List<ProductEntity> products = [];

  OrderEntity(this.id, this.dateTime, this.address, this.tableNum);

  OrderEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dateTime = DateTime.parse(json['dateTime']),
        address = json['address'],
        tableNum = json['tableNum'],
        status = OrderStatus.values.firstWhere(
                (e) => e.toString() == 'OrderStatus.' + (json['status'] as String)),
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
  delivered
}

extension OrderStatusExtension on OrderStatus {
  String get statusString {
    switch (this) {
      case OrderStatus.initial:
        return 'Ожидание подтверждения';
      case OrderStatus.confirmed:
        return 'Подтверждено';
      case OrderStatus.delivered:
        return 'Доставлено';
      default:
        return ''; // Или бросить исключение, если это не ожидаемое поведение
    }
  }
}