import 'package:arkeonil/categories/controller/categories_controller.dart';
import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/models/archae_category_models.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:arkeonil/router/router_names.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CategoryCitiesView extends ConsumerWidget {
  const CategoryCitiesView({
    required this.model,
    required this.selectedCity,
    super.key,
  });
  final ArchaeCategory model;
  final List<String> selectedCity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCity.first,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: whiteColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: scaffoldPadding,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<List<ArticleModel>>(
                    stream: ref
                        .watch(categoryControllerProvider)
                        .getArticlesCities(selectedCity),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        List<ArticleModel> articles = snapshot.data!;

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: articles.length,
                          itemBuilder: (BuildContext context, int index) {
                            final article = articles[index];
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, AppRouteNames.article,
                                  arguments: {'article': article}),
                              child: Padding(
                                padding: all15,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                  DateFormat("dd.MM.y").format(
                                                      article.createdAt),
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
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                    image:
                                                        CachedNetworkImageProvider(
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
                        return const Center(
                          child: Text("Error"),
                        );
                      } else {
                        return const Center(
                          child: Text("No Data"),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
