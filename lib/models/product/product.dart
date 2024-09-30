// ignore_for_file: unnecessary_getters_setters

import 'package:glamour_grove_cosmetics_app/models/product/review.dart';

import 'dimensions.dart';
import 'meta.dart';

class Product {
  int? _id;
  String? _title;
  String? _description;
  String? _category;
  double? _price;
  double? _discountPercentage;
  double? _rating;
  int? _stock;
  List<String>? _tags;
  String? _brand;
  String? _sku;
  double? _weight;
  Dimensions? _dimensions;
  String? _warrantyInformation;
  String? _shippingInformation;
  String? _availabilityStatus;
  List<Review>? _reviews;
  String? _returnPolicy;
  int? _minimumOrderQuantity;
  Meta? _meta;
  List<String>? _images;
  String? _thumbnail;

  Product({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    List<String>? tags,
    String? brand,
    String? sku,
    double? weight,
    Dimensions? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<Review>? reviews,
    String? returnPolicy,
    int? minimumOrderQuantity,
    Meta? meta,
    List<String>? images,
    String? thumbnail,
  }) {
    _id = id ?? 0;
    _title = title ?? '';
    _description = description ?? '';
    _category = category ?? '';
    _price = price ?? 0.0;
    _discountPercentage = discountPercentage ?? 0.0;
    _rating = rating ?? 0.0;
    _stock = stock ?? 0;
    _tags = tags ?? [];
    _brand = brand ?? '';
    _sku = sku ?? '';
    _weight = weight ?? 0.0;
    _dimensions = dimensions ?? Dimensions();
    _warrantyInformation = warrantyInformation ?? '';
    _shippingInformation = shippingInformation ?? '';
    _availabilityStatus = availabilityStatus ?? '';
    _reviews = reviews ?? [];
    _returnPolicy = returnPolicy ?? '';
    _minimumOrderQuantity = minimumOrderQuantity ?? 1;
    _meta = meta ?? Meta();
    _images = images ?? [];
    _thumbnail = thumbnail ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'title': _title,
      'description': _description,
      'category': _category,
      'price': _price,
      'discountPercentage': _discountPercentage,
      'rating': _rating,
      'stock': _stock,
      'tags': _tags,
      'brand': _brand,
      'sku': _sku,
      'weight': _weight,
      'dimensions': _dimensions?.toJson(),
      'warrantyInformation': _warrantyInformation,
      'shippingInformation': _shippingInformation,
      'availabilityStatus': _availabilityStatus,
      'reviews': _reviews?.map((r) => r.toJson()).toList(),
      'returnPolicy': _returnPolicy,
      'minimumOrderQuantity': _minimumOrderQuantity,
      'meta': _meta?.toJson(),
      'images': _images,
      'thumbnail': _thumbnail,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Product JSON is null");
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      weight: (json['weight'] ?? 0).toDouble(),
      dimensions: json['dimensions'] != null ? Dimensions.fromJson(json['dimensions']) : Dimensions(),
      warrantyInformation: json['warrantyInformation'] ?? '',
      shippingInformation: json['shippingInformation'] ?? '',
      availabilityStatus: json['availabilityStatus'] ?? '',
      reviews: json['reviews'] != null ? (json['reviews'] as List).map((r) => Review.fromJson(r)).toList() : [],
      returnPolicy: json['returnPolicy'] ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 1,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : Meta(),
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  String? get thumbnail => _thumbnail;

  set thumbnail(String? value) {
    _thumbnail = value;
  }

  List<String>? get images => _images;

  set images(List<String>? value) {
    _images = value;
  }

  Meta? get meta => _meta;

  set meta(Meta? value) {
    _meta = value;
  }

  int? get minimumOrderQuantity => _minimumOrderQuantity;

  set minimumOrderQuantity(int? value) {
    _minimumOrderQuantity = value;
  }

  String? get returnPolicy => _returnPolicy;

  set returnPolicy(String? value) {
    _returnPolicy = value;
  }

  List<Review>? get reviews => _reviews;

  set reviews(List<Review>? value) {
    _reviews = value;
  }

  String? get availabilityStatus => _availabilityStatus;

  set availabilityStatus(String? value) {
    _availabilityStatus = value;
  }

  String? get shippingInformation => _shippingInformation;

  set shippingInformation(String? value) {
    _shippingInformation = value;
  }

  String? get warrantyInformation => _warrantyInformation;

  set warrantyInformation(String? value) {
    _warrantyInformation = value;
  }

  Dimensions? get dimensions => _dimensions;

  set dimensions(Dimensions? value) {
    _dimensions = value;
  }

  double? get weight => _weight;

  set weight(double? value) {
    _weight = value;
  }

  String? get sku => _sku;

  set sku(String? value) {
    _sku = value;
  }

  String? get brand => _brand;

  set brand(String? value) {
    _brand = value;
  }

  List<String>? get tags => _tags;

  set tags(List<String>? value) {
    _tags = value;
  }

  int? get stock => _stock;

  set stock(int? value) {
    _stock = value;
  }

  double? get rating => _rating;

  set rating(double? value) {
    _rating = value;
  }

  double? get discountPercentage => _discountPercentage;

  set discountPercentage(double? value) {
    _discountPercentage = value;
  }

  double? get price => _price;

  set price(double? value) {
    _price = value;
  }

  String? get category => _category;

  set category(String? value) {
    _category = value;
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  String? get title => _title;

  set title(String? value) {
    _title = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }
}
