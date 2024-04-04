import 'package:arkeonil/categories/repository/categories_repository.dart';
import 'package:arkeonil/models/article_cities_model.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryControllerProvider = Provider((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoryController(categoryRepository: categoryRepository);
});

class CategoryController {
  final CategoryRepository categoryRepository;

  CategoryController({required this.categoryRepository});

  Stream<List<ArticleModel>> getArticles(String category) {
    return categoryRepository.getArticles(category);
  }

  Stream<List<ArticleCitiesModel>> getCitiesName(String category) {
    return categoryRepository.getCitiesName(category);
  }

  Stream<List<ArticleModel>> getArticlesCities(List<String> cityName) {
    return categoryRepository.getArticlesCities(cityName);
  }
}
