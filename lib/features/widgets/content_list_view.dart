import 'package:arkeonil/browse/controller/browse_controller.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:arkeonil/router/router_names.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../common/colors.dart';
import '../../common/sizes.dart';

class ContentListView extends ConsumerWidget {
  const ContentListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<ArticleModel>>(
        stream: ref.watch(browseControllerProvider).getArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            List<ArticleModel> articles = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, AppRouteNames.article,
                      arguments: {'article': article}),
                  child: Padding(
                    padding: right5,
                    child: AspectRatio(
                      aspectRatio: 1.15,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: buttonColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: all15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      article.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor,
                                      ),
                                    ),
                                    Text(
                                      article.author,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: whiteColor,
                                      ),
                                    ),
                                    Text(
                                      DateFormat("dd.MM.y")
                                          .format(article.createdAt),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: all10,
                                child: AspectRatio(
                                  aspectRatio: 0.50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            article.coverImg!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        });
  }
}
