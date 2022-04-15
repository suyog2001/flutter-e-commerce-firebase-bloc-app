import 'dart:convert';

class Product {
  String id;
  String uid;
  String name;
  String brand;
  String catagory;
  double price;
  Product({
    required this.id,
    required this.uid,
    required this.name,
    required this.brand,
    required this.catagory,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? uid,
    String? name,
    String? brand,
    String? catagory,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      catagory: catagory ?? this.catagory,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'brand': brand,
      'catagory': catagory,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      brand: map['brand'] ?? '',
      catagory: map['catagory'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, uid: $uid, name: $name, brand: $brand, catagory: $catagory, price: $price)';
  }
}
