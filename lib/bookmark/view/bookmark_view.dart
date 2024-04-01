import 'package:arkeonil/bookmark/controller/bookmark_controller.dart';
import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/paths.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:arkeonil/router/router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookmarkView extends ConsumerStatefulWidget {
  const BookmarkView({super.key});

  @override
  ConsumerState<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends ConsumerState<BookmarkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: StreamBuilder<List<ArticleModel>>(
              stream: ref.read(bookMarkControllerProvider).getArticleFavorite(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ArticleModel> articles = snapshot.data!;
                  return ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      final article = articles[index];
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, AppRouteNames.article,
                            arguments: {'article': article}),
                        child: Padding(
                          padding: vertical5,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          article.coverImg!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: horizontal10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        article.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                      ),
                                      Text(
                                        article.author,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: horizontal25,
                                      child: CircleAvatar(
                                        backgroundColor: buttonColor,
                                        child: SvgPicture.asset(
                                          bookmarkSvg,
                                          colorFilter: const ColorFilter.mode(
                                            whiteColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: horizontal10,
                                      child: CircleAvatar(
                                        backgroundColor: buttonColor,
                                        child: SvgPicture.asset(
                                          bookmarkSvg,
                                          colorFilter: const ColorFilter.mode(
                                            whiteColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'ERROR',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: whiteColor),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
