import 'package:arkeonil/categories/repository/categories_repository.dart';
import 'package:arkeonil/models/archae_category_models.dart';
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

  Stream<List<ArchaeCategory>> getCitiesName(
      String category, List<String> cityName) {
    return categoryRepository.getCitiesName(category, cityName);
  }

  Stream<List<ArticleModel>> getArticlesCities(List<String> cityName) {
    return categoryRepository.getArticlesCities(cityName);
  }
}
