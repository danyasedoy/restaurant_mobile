class ProductEntity {
  final int id;
  final String name;
  final double price;
  int count = 0;

  ProductEntity(this.id, this.name, this.price);

  ProductEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'].toDouble(),
        count = json['count'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'count': count,
  };
}