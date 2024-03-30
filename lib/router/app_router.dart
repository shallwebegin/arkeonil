import 'package:arkeonil/browse/view/article_view.dart';
import 'package:arkeonil/features/auth/views/sign_in.dart';
import 'package:arkeonil/features/home/home.dart';
import 'package:arkeonil/features/more/view/write_article.dart';
import 'package:arkeonil/features/more/view/your_articles.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:arkeonil/models/user_model.dart';
import 'package:arkeonil/router/router_names.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.home:
        return MaterialPageRoute(
          builder: (context) => const Home(),
        );
      case AppRouteNames.signIn:
        return MaterialPageRoute(builder: (context) => const SignIn());
      case AppRouteNames.writeArticle:
        final arguments = settings.arguments as Map<String, dynamic>;
        final currentUser = arguments['currentUser'] as UserModel;
        return MaterialPageRoute(
          builder: (context) => WriteArticle(currentUser: currentUser),
        );
      case AppRouteNames.article:
        final arguments = settings.arguments as Map<String, dynamic>;
        final article = arguments['article'] as ArticleModel;
        return MaterialPageRoute(
          builder: (context) => ArticleView(article: article),
        );
      case AppRouteNames.yourArticles:
        return MaterialPageRoute(
          builder: (context) => const YourArticles(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SignIn(),
        );
    }
  }
}
