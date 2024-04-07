// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ArchaeCategory {
  final String category;
  final String categoryId;
  final String image;
  final List<String> cityName;
  ArchaeCategory({
    required this.category,
    required this.categoryId,
    required this.image,
    required this.cityName,
  });

  ArchaeCategory copyWith({
    String? category,
    String? categoryId,
    String? image,
    List<String>? cityName,
  }) {
    return ArchaeCategory(
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
      cityName: cityName ?? this.cityName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'categoryId': categoryId,
      'image': image,
      'cityName': cityName,
    };
  }

  factory ArchaeCategory.fromMap(Map<String, dynamic> map) {
    return ArchaeCategory(
        category: map['category'] as String,
        categoryId: map['categoryId'] as String,
        image: map['image'] as String,
        cityName: List<String>.from(
          (map['cityName'] as List<dynamic>).cast<String>(),
        ));
  }

  String toJson() => json.encode(toMap());

  factory ArchaeCategory.fromJson(String source) =>
      ArchaeCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ArchaeCategory(category: $category, categoryId: $categoryId, image: $image, cityName: $cityName)';
  }

  @override
  bool operator ==(covariant ArchaeCategory other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.categoryId == categoryId &&
        other.image == image &&
        listEquals(other.cityName, cityName);
  }

  @override
  int get hashCode {
    return category.hashCode ^
        categoryId.hashCode ^
        image.hashCode ^
        cityName.hashCode;
  }
}
