// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Cookie {
  Cookie(
      {required this.id,
      this.name,
      this.description,
      this.price,
      this.originalPrice,
      this.ingredients,
      this.stock});
  final String id;
  final String? name;
  final String? description;
  final double? price;
  final double? originalPrice;
  final int? stock;
  final List<dynamic>? ingredients;

  Cookie copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    int? stock,
    List<dynamic>? ingredients,
  }) {
    return Cookie(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        originalPrice: originalPrice ?? this.originalPrice,
        ingredients: ingredients ?? this.ingredients,
        stock: stock ?? this.stock);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'ingredients': ingredients,
      'stock': stock
    };
  }

  factory Cookie.fromMap(Map<String, dynamic> map) {
    return Cookie(
        id: map['id'] as String,
        name: map['name'] != null ? map['name'] as String : null,
        description:
            map['description'] != null ? map['description'] as String : null,
        price: map['price'] != null ? map['price'] as double : null,
        originalPrice: map['originalPrice'] != null
            ? map['originalPrice'] as double
            : null,
        ingredients: map['ingredients'] != null
            ? List<dynamic>.from((map['ingredients'] as List<dynamic>))
            : null,
        stock: map['stock'] != null ? map['stock'] as int : null);
  }

  String toJson() => json.encode(toMap());

  factory Cookie.fromJson(String source) =>
      Cookie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cookie(id: $id, name: $name, description: $description, price: $price, originalPrice: $originalPrice, ingredients: $ingredients, stock: $stock)';
  }

  @override
  bool operator ==(covariant Cookie other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.originalPrice == originalPrice &&
        other.stock == stock &&
        listEquals(other.ingredients, ingredients);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        originalPrice.hashCode ^
        ingredients.hashCode ^
        stock.hashCode;
  }
}
