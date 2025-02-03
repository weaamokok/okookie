// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Cookie {
  Cookie({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.ingredients,
  });
  final String? id;
  final String? name;
  final String? description;
  final Price? price;

  final int? stock;
  final List<dynamic>? ingredients;
const Cookie.mock({this.id='', this.name='', this.description='', this.price=const Price.mock() , this.stock=9, this.ingredients=const []});
  Cookie copyWith({
    String? id,
    String? name,
    String? description,
    Price? price,
    int? stock,
    List<dynamic>? ingredients,
  }) {
    return Cookie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price?.toMap(),
      'stock': stock,
      'ingredients': ingredients,
    };
  }

  factory Cookie.fromMap(Map<String, dynamic> map) {
    return Cookie(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null
          ? Price.fromMap(map['price'] as Map<String, dynamic>)
          : null,
      stock: map['stock'] != null ? map['stock'] as int : null,
      ingredients: map['ingredients'] != null
          ? List<dynamic>.from((map['ingredients'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cookie.fromJson(String source) =>
      Cookie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cookie(id: $id, name: $name, description: $description, price: $price, stock: $stock, ingredients: $ingredients)';
  }

  @override
  bool operator ==(covariant Cookie other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.stock == stock &&
        listEquals(other.ingredients, ingredients);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        stock.hashCode ^
        ingredients.hashCode;
  }
}

class Price {
  Price({
    required this.currency,
    required this.value,
    this.originalPrice,
  });
  final String currency;
  final double value;
  final String? originalPrice;
const Price.mock({this.value= 0.0,this.currency='',this.originalPrice});
  Price copyWith({
    String? currency,
    double? price,
    String? originalPrice,
  }) {
    return Price(
      currency: currency ?? this.currency,
      value: value ,
      originalPrice: originalPrice ?? this.originalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currency': currency,
      'value': value,
      'originalPrice': originalPrice,
    };
  }

  factory Price.fromMap(Map<String, dynamic> map) {
    return Price(
      currency: map['currency'] as String,
      value: map['value'] as double,
      originalPrice:
          map['originalPrice'] != null ? map['originalPrice'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Price.fromJson(String source) =>
      Price.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Price(currency: $currency, value: $value, originalPrice: $originalPrice)';

  @override
  bool operator ==(covariant Price other) {
    if (identical(this, other)) return true;

    return other.currency == currency &&
        other.value == value &&
        other.originalPrice == originalPrice;
  }

  @override
  int get hashCode =>
      currency.hashCode ^ value.hashCode ^ originalPrice.hashCode;
}
