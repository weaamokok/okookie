// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Cookie {
  Cookie({
    this.id,
    this.name,
    this.description,
    this.price,
    this.isFeatured,
    this.stock,
    this.ingredients,
    this.images,
  });
      
  final String? id;
  final String? name;
  final String? description;
  final Price? price;
  final bool? isFeatured;
  final int? stock;
  final List<dynamic>? ingredients;
  final List<dynamic>? images;

  const Cookie.mock(
      {this.id = '',
      this.name = '',
      this.description = '',
      this.price = const Price.mock(),
      this.stock = 9,
      this.ingredients = const [],
      this.isFeatured = false,
      this.images = const []});


  Cookie copyWith({
    String? id,
    String? name,
    String? description,
    Price? price,
    bool? isFeatured,
    int? stock,
    List<dynamic>? ingredients,
    List<dynamic>? images,
  }) {
    return Cookie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isFeatured: isFeatured ?? this.isFeatured,
      stock: stock ?? this.stock,
      ingredients: ingredients ?? this.ingredients,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price?.toMap(),
      'isFeatured': isFeatured,
      'stock': stock,
      'ingredients': ingredients,
      'images': images,
    };
  }

  factory Cookie.fromMap(Map<String, dynamic> map) {
    return Cookie(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? Price.fromMap(map['price'] as Map<String,dynamic>) : null,
      isFeatured: map['isFeatured'] != null ? map['isFeatured'] as bool : null,
      stock: map['stock'] != null ? map['stock'] as int : null,
      ingredients: map['ingredients'] != null ? List<dynamic>.from((map['ingredients'] as List<dynamic>)) : null,
      images: map['images'] != null ? List<dynamic>.from((map['images'] as List<dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cookie.fromJson(String source) => Cookie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cookie(id: $id, name: $name, description: $description, price: $price, isFeatured: $isFeatured, stock: $stock, ingredients: $ingredients, images: $images)';
  }

  @override
  bool operator ==(covariant Cookie other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.price == price &&
      other.isFeatured == isFeatured &&
      other.stock == stock &&
      listEquals(other.ingredients, ingredients) &&
      listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      isFeatured.hashCode ^
      stock.hashCode ^
      ingredients.hashCode ^
      images.hashCode;
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
  const Price.mock({this.value = 0.0, this.currency = '', this.originalPrice});
  Price copyWith({
    String? currency,
    double? price,
    String? originalPrice,
  }) {
    return Price(
      currency: currency ?? this.currency,
      value: value,
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
