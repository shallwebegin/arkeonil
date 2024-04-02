class ArchaeCategory {
  final String category;
  final String categoryId;
  final String image;
  ArchaeCategory({
    required this.category,
    required this.categoryId,
    required this.image,
  });

  ArchaeCategory copyWith({
    String? category,
    String? categoryId,
    String? image,
  }) {
    return ArchaeCategory(
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'categoryId': categoryId,
      'image': image,
    };
  }

  factory ArchaeCategory.fromMap(Map<String, dynamic> map) {
    return ArchaeCategory(
      category: map['category'] as String,
      categoryId: map['categoryId'] as String,
      image: map['image'] as String,
    );
  }

  @override
  String toString() =>
      'ArchaeCategory(category: $category, categoryId: $categoryId, image: $image)';

  @override
  bool operator ==(covariant ArchaeCategory other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.categoryId == categoryId &&
        other.image == image;
  }

  @override
  int get hashCode => category.hashCode ^ categoryId.hashCode ^ image.hashCode;
}
