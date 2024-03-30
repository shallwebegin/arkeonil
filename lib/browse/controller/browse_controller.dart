import 'package:arkeonil/browse/repository/browse_repository.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final browseControllerProvider = Provider(
  (ref) => BrowseController(
    browseRepository: ref.watch(browseRepositoryProvider),
  ),
);

class BrowseController {
  final BrowseRepository browseRepository;

  BrowseController({required this.browseRepository});

  Stream<List<ArticleModel>> getArticles() {
    return browseRepository.getArticles();
  }

  Future<Stream<List<ArticleModel>>> setArticlesFavorites(
      String articleId, bool isFavorite) async {
    return await browseRepository.setArticlesFavorites(articleId, isFavorite);
  }
}
