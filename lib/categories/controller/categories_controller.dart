import 'package:arkeonil/categories/repository/categories_repository.dart';
import 'package:arkeonil/models/archae_category_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryControllerProvider = Provider((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoryController(categoryRepository: categoryRepository);
});

class CategoryController {
  final CategoryRepository categoryRepository;

  CategoryController({required this.categoryRepository});

  Stream<List<ArchaeCategory>> getProfilePhotosArch() {
    return categoryRepository.getProfilePhotosArch();
  }
}
