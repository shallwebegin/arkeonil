class ArticleCitiesModel {
  final String categoryId;
  final String category;
  final String cityName;

  ArticleCitiesModel({
    required this.categoryId,
    required this.category,
    required this.cityName,
  });

  ArticleCitiesModel copyWith({
    String? categoryId,
    String? category,
    String? cityName,
  }) {
    return ArticleCitiesModel(
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      cityName: cityName ?? this.cityName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'category': category,
      'cityName': cityName,
    };
  }

  factory ArticleCitiesModel.fromMap(Map<String, dynamic> map) {
    return ArticleCitiesModel(
      categoryId: map['categoryId'] as String,
      category: map['category'] as String,
      cityName: map['cityName'] as String,
    );
  }

  @override
  String toString() =>
      'ArticleCitiesModel(categoryId: $categoryId, category: $category, cityName: $cityName)';

  @override
  bool operator ==(covariant ArticleCitiesModel other) {
    if (identical(this, other)) return true;

    return other.categoryId == categoryId &&
        other.category == category &&
        other.cityName == cityName;
  }

  @override
  int get hashCode =>
      categoryId.hashCode ^ category.hashCode ^ cityName.hashCode;
}
