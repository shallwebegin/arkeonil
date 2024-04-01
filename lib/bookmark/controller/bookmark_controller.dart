import 'package:arkeonil/bookmark/repository/bookmark_repository.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:arkeonil/models/favorite_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookMarkControllerProvider = Provider(
  (ref) => BookMarkController(
    bookmarkRepository: ref.watch(bookMarkRepositoryProvider),
  ),
);

class BookMarkController {
  final BookMarkRepository bookmarkRepository;

  BookMarkController({required this.bookmarkRepository});

  Stream<List<ArticleModel>> getArticleFavorite() {
    return bookmarkRepository.getArticleFavorite();
  }

  Future<void> setArticleFavorite(FavoriteModel model) async {
    await bookmarkRepository.setArticleFavorite(model);
  }
}
