import 'package:arkeonil/features/more/repository/more_repository.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:arkeonil/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moreControllerProvider = Provider((ref) {
  final moreRepository = ref.watch(moreRepositoryProvider);
  return MoreController(moreRepository: moreRepository, ref: ref);
});

class MoreController {
  final MoreRepository moreRepository;
  final ProviderRef ref;

  MoreController({required this.moreRepository, required this.ref});

  Future<void> writeArticles(ArticleModel model) async {
    await moreRepository.writeArticle(model);
  }

  Stream<List<ArticleModel>> getArticle() {
    return moreRepository.getArticle();
  }

  Future<UserModel> getUser() async {
    return await moreRepository.getUser();
  }

  Future<void> signOut() async {
    return await moreRepository.signOut();
  }
}
