import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/paths.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/features/more/controller/more_controller.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:arkeonil/router/router_names.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YourArticles extends ConsumerWidget {
  const YourArticles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.of(context).pop(),
          color: whiteColor,
        ),
        title: Text(
          'Your Articles',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: whiteColor),
        ),
      ),
      body: Padding(
        padding: scaffoldPadding,
        child: StreamBuilder<List<ArticleModel>>(
            stream: ref.read(moreControllerProvider).getArticle(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final articles = snapshot.data!;
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouteNames.article,
                            arguments: {'article': article});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            article.coverImg!),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: horizontal10,
                                child: Column(
                                  children: [
                                    Text(
                                      article.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(color: whiteColor),
                                    ),
                                    Padding(
                                      padding: top10,
                                      child: Text(
                                        article.author,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: whiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: horizontal10,
                                  child: CircleAvatar(
                                    backgroundColor: buttonColor,
                                    child: SvgPicture.asset(
                                      bookmarkSvg,
                                      colorFilter: const ColorFilter.mode(
                                          whiteColor, BlendMode.srcIn),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            }),
      ),
    );
  }
}
